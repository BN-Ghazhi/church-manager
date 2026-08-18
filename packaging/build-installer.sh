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
# Reports progress without blocking. A modal dialog that waits for a click
# leaves the installer looking hung when nobody is watching, so the notice
# closes itself and the process never waits on it.
notify() {
  local title="$1" body="$2"
  printf '%s\n%s\n' "$title" "$body"
  if command -v zenity >/dev/null 2>&1; then
    ( zenity --info --title="$title" --text="$body" --width=420 \
        --timeout=12 >/dev/null 2>&1 || true ) &
  elif command -v notify-send >/dev/null 2>&1; then
    notify-send "$title" "$body" 2>/dev/null || true
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

# Open the app straight away: someone who just ran an installer wants to see the
# thing they installed. Detached, so the installer exits immediately.
setsid "$INSTALL_DIR/churchms" >/dev/null 2>&1 < /dev/null &

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

# Modern GNOME (42+, and strictly from 50) refuses to execute .desktop files
# from arbitrary folders, and the old metadata::trusted flag no longer exists.
# A launcher sitting in dist/ therefore opens in a text editor rather than
# running — which is exactly what happens on this machine.
#
# So instead of shipping a clickable file, register the installer in the
# applications menu, where GNOME does trust launchers. `register-installer.sh`
# does that; from then on the installer is a menu entry like any other app.
cat > "$OUT/register-installer.sh" <<REGISTER
#!/usr/bin/env bash
#
# Adds "Install Church Management" to your applications menu.
#
# Needed because GNOME will not run a .desktop file from a normal folder — it
# only trusts launchers already registered in the applications directory.
set -euo pipefail

PAYLOAD="\$(cd "\$(dirname "\$(readlink -f "\$0")")" && pwd)/Install-Church-Management.run"
APPS="\$HOME/.local/share/applications"

[[ -f "\$PAYLOAD" ]] || { echo "Install-Church-Management.run is missing from this folder."; exit 1; }
chmod +x "\$PAYLOAD"
mkdir -p "\$APPS"

cat > "\$APPS/church-management-installer.desktop" <<DESKTOP
[Desktop Entry]
Type=Application
Name=Install Church Management
Comment=Installs Church Management for the current user
Exec=\$PAYLOAD
Icon=$PROJECT_ROOT/packaging/icon.png
Terminal=false
Categories=System;
DESKTOP

command -v update-desktop-database >/dev/null 2>&1 \\
  && update-desktop-database "\$APPS" 2>/dev/null || true

echo "Added to your applications menu."
echo "Search for \"Install Church Management\" and click it."
REGISTER
chmod +x "$OUT/register-installer.sh"

echo "Built:"
printf '  %s\t%s\n' "$(du -h "$INSTALLER" | cut -f1)" "$(basename "$INSTALLER")"
echo
echo "Install now, one command:"
echo "  ./dist/Install-Church-Management.run"
echo
echo "Or to get a clickable menu entry instead of using the terminal:"
echo "  ./dist/register-installer.sh"
echo "then search your applications menu for \"Install $APP_NAME\"."
