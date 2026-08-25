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
ICON_ROOT="$HOME/.local/share/icons/hicolor"

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
mkdir -p "$INSTALL_DIR" "$BIN_DIR" "$DESKTOP_DIR" "$DATA_DIR"
cp -a "$WORK/bundle/." "$INSTALL_DIR/"
ln -sf "$INSTALL_DIR/churchms" "$BIN_DIR/churchms"
# Every icon-theme size the payload carries.
for size in 16 24 32 48 64 128 256 512; do
  src="$WORK/icons/$size.png"
  [[ -f "$src" ]] || continue
  dest="$ICON_ROOT/${size}x${size}/apps"
  mkdir -p "$dest"
  cp "$src" "$dest/$APP_ID.png"
done

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

# An uninstaller, installed alongside the app.
#
# Without this, removing the app would need the project folder — which will not
# exist on a machine that only ever ran the installer. It is written here rather
# than shipped in the payload so the paths are already resolved.
cat > "$INSTALL_DIR/uninstall" <<'UNINSTALL'
#!/usr/bin/env bash
#
# Removes Church Management.
#
# Your records are kept by default: uninstalling the program must not destroy the
# church's data. Pass --purge to delete the database as well.

set -euo pipefail

APP_ID="org.gracechapel.churchms"
APP_NAME="Church Management"
INSTALL_DIR="$HOME/.local/lib/$APP_ID"
DATA_DIR="$HOME/.local/share/$APP_ID"
DB="$DATA_DIR/church_management.sqlite"
PURGE="${1:-}"

ask() {
  if command -v zenity >/dev/null 2>&1; then
    zenity --question --title="Remove $APP_NAME?" --width=400 \
      --text="$1" 2>/dev/null
  else
    read -r -p "$1 [y/N] " reply
    [[ "$reply" == [yY]* ]]
  fi
}

tell() {
  printf '%s\n' "$1"
  if command -v zenity >/dev/null 2>&1; then
    ( zenity --info --title="$APP_NAME" --text="$1" --width=400 \
        --timeout=12 >/dev/null 2>&1 || true ) &
  fi
}

# Launched from the menu there is no terminal, so confirm before destroying
# anything.
if [[ "$PURGE" != "--purge" && "$PURGE" != "--yes" ]]; then
  if ! ask "Remove $APP_NAME?

Your records are kept and will still be there if you reinstall."; then
    exit 0
  fi
fi

# Close the app first, or files are removed from under a running process.
pkill -x churchms 2>/dev/null || true
sleep 1

rm -rf "$INSTALL_DIR"
rm -f "$HOME/.local/bin/churchms"
rm -f "$HOME/.local/share/applications/$APP_ID.desktop"
rm -f "$HOME/.local/share/applications/$APP_ID-uninstall.desktop"
rm -f "$HOME/.local/share/applications/church-management-installer.desktop"
for size in 16 24 32 48 64 128 256 512; do
  rm -f "$HOME/.local/share/icons/hicolor/${size}x${size}/apps/$APP_ID.png"
done

command -v update-desktop-database >/dev/null 2>&1 \
  && update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

if [[ "$PURGE" == "--purge" ]]; then
  rm -rf "$DATA_DIR"
  tell "$APP_NAME and all its records have been removed."
elif [[ -f "$DB" ]]; then
  tell "$APP_NAME has been removed.

Your records are still here:
$DB

Reinstalling picks them up again. To delete them too, run:
$INSTALL_DIR/uninstall --purge"
else
  tell "$APP_NAME has been removed."
fi
UNINSTALL
chmod +x "$INSTALL_DIR/uninstall"

# A menu entry for it, so removing the app does not require a terminal either.
cat > "$DESKTOP_DIR/$APP_ID-uninstall.desktop" <<UNDESKTOP
[Desktop Entry]
Type=Application
Name=Uninstall $APP_NAME
Comment=Removes $APP_NAME but keeps your records
Exec=$INSTALL_DIR/uninstall
Icon=$APP_ID
Terminal=false
Categories=System;
UNDESKTOP
chmod 644 "$DESKTOP_DIR/$APP_ID-uninstall.desktop"

command -v update-desktop-database >/dev/null 2>&1 \
  && update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
command -v gtk-update-icon-cache >/dev/null 2>&1 \
  && gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

notify "$APP_NAME installed" \
"$APP_NAME is ready.

Find it in your applications menu, or run 'churchms' in a terminal.

To remove it later, use \"Uninstall $APP_NAME\" in the same menu.

Your records live at:
$DATA_DIR
and survive both reinstalling and uninstalling."

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
[[ -d "$PROJECT_ROOT/packaging/icons" ]] && \
  cp -a "$PROJECT_ROOT/packaging/icons" "$STAGE/icons"

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
