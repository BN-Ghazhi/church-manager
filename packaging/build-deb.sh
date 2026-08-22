#!/usr/bin/env bash
#
# Builds a .deb package for Debian/Ubuntu machines.
#
# Produces dist/church-management_<version>_amd64.deb, which anyone can install
# with a double-click or:  sudo apt install ./church-management_*.deb
#
# Usage: ./packaging/build-deb.sh

set -euo pipefail

APP_ID="org.gracechapel.churchms"
PKG="church-management"
VERSION="$(grep '^version:' "$(dirname "${BASH_SOURCE[0]}")/../pubspec.yaml" \
  | awk '{print $2}' | cut -d+ -f1)"
ARCH="amd64"

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUNDLE="$PROJECT_ROOT/build/linux/x64/release/bundle"
STAGE="$PROJECT_ROOT/build/deb/$PKG"
OUT="$PROJECT_ROOT/dist"

if [[ ! -x "$BUNDLE/churchms" ]]; then
  echo "No release build found. Run first:"
  echo "  flutter build linux --release"
  exit 1
fi

rm -rf "$STAGE"
mkdir -p "$STAGE/DEBIAN" \
         "$STAGE/opt/$APP_ID" \
         "$STAGE/usr/bin" \
         "$STAGE/usr/share/applications" \
         "$STAGE/usr/share/icons/hicolor/256x256/apps"

cp -a "$BUNDLE/." "$STAGE/opt/$APP_ID/"
[[ -f "$PROJECT_ROOT/packaging/icon.png" ]] && \
  cp "$PROJECT_ROOT/packaging/icon.png" \
     "$STAGE/usr/share/icons/hicolor/256x256/apps/$APP_ID.png"

ln -sf "/opt/$APP_ID/churchms" "$STAGE/usr/bin/churchms"

cat > "$STAGE/usr/share/applications/$APP_ID.desktop" <<DESKTOP
[Desktop Entry]
Type=Application
Name=Church Management
GenericName=Church Administration
Comment=Members, attendance, giving, departments and branches
Exec=/opt/$APP_ID/churchms
Icon=$APP_ID
Terminal=false
Categories=Office;
StartupWMClass=churchms
DESKTOP

# Runtime libraries the Flutter Linux shell links against. Without these the
# app installs but fails to start on a machine that lacks them.
cat > "$STAGE/DEBIAN/control" <<CONTROL
Package: $PKG
Version: $VERSION
Section: office
Priority: optional
Architecture: $ARCH
Depends: libgtk-3-0 | libgtk-3-0t64, libblkid1, liblzma5, libsqlite3-0
Maintainer: Kingdom Grace Chapel <office@kgc.org>
Description: Church Management System
 Members, attendance, giving, events, volunteers, pastoral care and
 departments across multiple branches. Stores its data locally in
 SQLite and runs entirely offline.
CONTROL

cat > "$STAGE/DEBIAN/postinst" <<'POSTINST'
#!/bin/sh
set -e
# Refresh the menu and icon cache so the entry appears without a logout.
if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database -q /usr/share/applications || true
fi
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
  gtk-update-icon-cache -q -f -t /usr/share/icons/hicolor || true
fi
POSTINST
chmod 755 "$STAGE/DEBIAN/postinst"

mkdir -p "$OUT"
DEB="$OUT/${PKG}_${VERSION}_${ARCH}.deb"
dpkg-deb --build --root-owner-group "$STAGE" "$DEB" >/dev/null

echo "Built: $DEB"
du -h "$DEB" | awk '{print "Size:  " $1}'
echo
echo "Install on any Debian/Ubuntu machine:"
echo "  sudo apt install ./$(basename "$DEB")"
