#!/usr/bin/env bash
#
# Builds a single double-clickable installer for Linux.
#
# Produces dist/Install-Church-Management.desktop plus a self-extracting
# payload. Double-clicking it installs the app for the current user — no
# terminal, no root, no package manager involved.
#
# Why not just the .deb? A .deb needs a graphical package installer, and on this
# machine .deb files are registered to snap-store, which cannot install them.
# Installing per-user sidesteps that entirely and needs no password.
#
# Usage: ./packaging/build-installer.sh

set -euo pipefail

APP_ID="org.gracechapel.churchms"
APP_NAME="Church Management"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUNDLE="$PROJECT_ROOT/build/linux/x64/release/bundle"
OUT="$PROJECT_ROOT/dist"

if [[ ! -x "$BUNDLE/churchms" ]]; then
  echo "No release build found. Run first:"
  echo "  flutter build linux --release"
  exit 1
fi

mkdir -p "$OUT"
INSTALLER="$OUT/Install-Church-Management.run"

echo "Packing the application…"

# A self-extracting shell archive: the installer logic, then a tar payload
# appended after a marker line. Running it unpacks to a temp dir and installs.
cat > "$INSTALLER" <<'HEADER'
#!/usr/bin/env bash
#
# Church Management System — installer.
#
# Installs for the current user only. Nothing outside your home directory is
# touched and no password is needed.

set -euo pipefail

APP_ID="org.gracechapel.churchms"
APP_NAME="Church Management"
INSTALL_DIR="$HOME/.local/lib/$APP_ID"
DATA_DIR="$HOME/.local/share/$APP_ID"
BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"

# When double-clicked there is no terminal to read, so report through a dialog
# if one is available and fall back to stdout otherwise.
notify() {
  local title="$1" body="$2"
  if command -v zenity >/dev/null 2>&1; then
    zenity --info --title="$title" --text="$body" --width=420 2>/dev/null || true
  elif command -v kdialog >/dev/null 2>&1; then
    kdialog --msgbox "$body" 2>/dev/null || true
  else
    printf '%s\n%s\n' "$title" "$body"
  fi
}

fail() {
  local body="$1"
  if command -v zenity >/dev/null 2>&1; then
    zenity --error --title="Install failed" --text="$body" --width=420 2>/dev/null || true
  else
    printf 'Install failed\n%s\n' "$body" >&2
  fi
  exit 1
}

# Unpack the payload that follows the marker.
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

ARCHIVE_LINE=$(awk '/^__PAYLOAD_BELOW__$/ {print NR + 1; exit 0}' "$0")
tail -n "+$ARCHIVE_LINE" "$0" | tar xz -C "$WORK" 2>/dev/null \
  || fail "The installer archive could not be unpacked."

[[ -x "$WORK/bundle/churchms" ]] || fail "The application files are missing."

# Replace any previous install so an upgrade leaves no stale libraries. The
# database lives in a separate directory and is deliberately untouched.
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR" "$BIN_DIR" "$DESKTOP_DIR" "$ICON_DIR" "$DATA_DIR"
cp -a "$WORK/bundle/." "$INSTALL_DIR/"
ln -sf "$INSTALL_DIR/churchms" "$BIN_DIR/churchms"
[[ -f "$WORK/icon.png" ]] && cp "$WORK/icon.png" "$ICON_DIR/$APP_ID.png"

cat > "$DESKTOP_DIR/$APP_ID.desktop" <<DESKTOP
[Desktop Entry]
Type=Application
Name=$APP_NAME
GenericName=Church Administration
Comment=Members, attendance, giving, departments and branches
Exec=$INSTALL_DIR/churchms
Icon=$APP_ID
Terminal=false
Categories=Office;
StartupWMClass=churchms
DESKTOP
chmod 644 "$DESKTOP_DIR/$APP_ID.desktop"

command -v update-desktop-database >/dev/null 2>&1 \
  && update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
command -v gtk-update-icon-cache >/dev/null 2>&1 \
  && gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

notify "$APP_NAME installed" \
"$APP_NAME is ready.

Find it in your applications menu, or run 'churchms' in a terminal.

Your data is kept separately at:
$DATA_DIR
and survives reinstalling."

# Offer to open it straight away.
if command -v zenity >/dev/null 2>&1; then
  if zenity --question --title="$APP_NAME" \
       --text="Open $APP_NAME now?" --width=320 2>/dev/null; then
    setsid "$INSTALL_DIR/churchms" >/dev/null 2>&1 < /dev/null &
  fi
fi

exit 0
__PAYLOAD_BELOW__
HEADER

# Append the payload: the app bundle plus the icon.
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
mkdir -p "$STAGE/bundle"
cp -a "$BUNDLE/." "$STAGE/bundle/"
[[ -f "$PROJECT_ROOT/packaging/icon.png" ]] && \
  cp "$PROJECT_ROOT/packaging/icon.png" "$STAGE/icon.png"

tar czf - -C "$STAGE" . >> "$INSTALLER"
chmod +x "$INSTALLER"

# GNOME opens .run files in a text editor rather than executing them, so ship a
# .desktop launcher alongside: desktop files ARE executed on double-click.
#
# Exec must be a plain command — the desktop-entry spec forbids shell syntax
# there — so the launcher points at a tiny wrapper that locates the payload
# beside itself and runs it.
WRAPPER="$OUT/.install-church-management"
cat > "$WRAPPER" <<'WRAP'
#!/usr/bin/env bash
# Runs the installer sitting next to this script.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"
exec ./Install-Church-Management.run
WRAP
chmod +x "$WRAPPER"

LAUNCHER="$OUT/Install $APP_NAME.desktop"
cat > "$LAUNCHER" <<LAUNCH
[Desktop Entry]
Type=Application
Name=Install $APP_NAME
Comment=Installs $APP_NAME for the current user; no password needed
Exec=$WRAPPER
Icon=$PROJECT_ROOT/packaging/icon.png
Terminal=false
Categories=System;
LAUNCH
chmod +x "$LAUNCHER"

echo "Built:"
printf '  %s\t%s\n' "$(du -h "$INSTALLER" | cut -f1)" "$(basename "$INSTALLER")"
printf '  %s\t%s\n' "$(du -h "$LAUNCHER"  | cut -f1)" "$(basename "$LAUNCHER")"
echo
echo "To install: double-click \"Install $APP_NAME\" in the dist folder."
echo "From a terminal instead:  ./dist/Install-Church-Management.run"
