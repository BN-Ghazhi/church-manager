#!/usr/bin/env bash
#
# Installs Church Management System for the current user.
#
# Copies the built bundle into ~/.local/share, registers a desktop entry so it
# appears in the applications menu, and installs the icon. No root needed and
# nothing outside the home directory is touched.
#
# Usage:  ./packaging/install-linux.sh
# Remove: ./packaging/uninstall-linux.sh

set -euo pipefail

APP_ID="org.gracechapel.churchms"
APP_NAME="Church Management"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUNDLE="$PROJECT_ROOT/build/linux/x64/release/bundle"

# Program files go under /opt-style user prefix; the database lives in
# ~/.local/share/$APP_ID, which path_provider owns. Keeping them apart means a
# reinstall replaces the app without touching the church's records.
INSTALL_DIR="$HOME/.local/lib/$APP_ID"
DATA_DIR="$HOME/.local/share/$APP_ID"
BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"

if [[ ! -x "$BUNDLE/churchms" ]]; then
  echo "No release build found at:"
  echo "  $BUNDLE"
  echo
  echo "Build it first:"
  echo "  flutter build linux --release"
  exit 1
fi

echo "Installing $APP_NAME…"

# Replace any previous install so upgrades do not leave stale libraries behind.
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR" "$BIN_DIR" "$DESKTOP_DIR" "$ICON_DIR"
cp -a "$BUNDLE/." "$INSTALL_DIR/"

# Launcher on PATH, for starting it from a terminal.
ln -sf "$INSTALL_DIR/churchms" "$BIN_DIR/churchms"

if [[ -f "$PROJECT_ROOT/packaging/icon.png" ]]; then
  cp "$PROJECT_ROOT/packaging/icon.png" "$ICON_DIR/$APP_ID.png"
fi

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

# Refresh the menu so it shows up without a logout.
command -v update-desktop-database >/dev/null 2>&1 \
  && update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
command -v gtk-update-icon-cache >/dev/null 2>&1 \
  && gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

echo
echo "Installed."
echo "  Application menu:  search for \"$APP_NAME\""
echo "  Terminal:          churchms"
echo "  Files:             $INSTALL_DIR"
echo
echo "Your data lives separately and survives reinstalls:"
echo "  $DATA_DIR/church_management.sqlite"

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo
  echo "Note: $BIN_DIR is not on your PATH, so the 'churchms' command will not"
  echo "work until you add it. The menu entry works regardless."
fi
