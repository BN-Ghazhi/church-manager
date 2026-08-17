#!/usr/bin/env bash
#
# Removes the application. Your database is left untouched by default —
# uninstalling should not destroy the church's records.
#
# Usage: ./packaging/uninstall-linux.sh [--purge]
#        --purge also deletes the database.

set -euo pipefail

APP_ID="org.gracechapel.churchms"
INSTALL_DIR="$HOME/.local/lib/$APP_ID"
DATA_DIR="$HOME/.local/share/$APP_ID"
DB="$DATA_DIR/church_management.sqlite"
PURGE="${1:-}"

# The app and its data are in separate directories, so removing the program
# leaves the database alone unless --purge is given.
rm -rf "$INSTALL_DIR"
rm -f "$HOME/.local/bin/churchms"
rm -f "$HOME/.local/share/applications/$APP_ID.desktop"
rm -f "$HOME/.local/share/icons/hicolor/256x256/apps/$APP_ID.png"

if [[ "$PURGE" == "--purge" ]]; then
  rm -rf "$DATA_DIR"
  echo "Removed, including the database."
elif [[ -f "$DB" ]]; then
  echo "Removed. Your database was kept:"
  echo "  $DB"
  echo "Delete it too with: ./packaging/uninstall-linux.sh --purge"
else
  echo "Removed."
fi
