#!/bin/sh
# Builds a self-contained gEEProg.app for macOS using PyInstaller.
#
# Usage (from anywhere):
#     sh build/osx/build_app.sh
#
# Set PYTHON to choose the interpreter used for the build. It must have a
# working Tkinter (check with: $PYTHON -m tkinter). Avoid Anaconda Python, it
# bundles many unneeded libraries.
#
# The result is dist/gEEProg.app (and dist/gEEProg.zip for sharing), ad-hoc
# signed. To distribute without Gatekeeper warnings, sign with a Developer ID
# certificate and notarize it with xcrun notarytool.

set -e

PYTHON="${PYTHON:-/opt/homebrew/bin/python3.11}"
BUNDLE_ID="com.dasarodesigns.gEEProg"

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
WORK="$ROOT/build/osx/work"
VENV="$WORK/venv"

cd "$ROOT"
VERSION="$(sed -n "s/^__version__ = '\(.*\)'/\1/p" src/gEEProgGUI)"

if [ ! -x "$VENV/bin/python" ]; then
    "$PYTHON" -m venv "$VENV"
fi
"$VENV/bin/pip" install --quiet --upgrade pip
"$VENV/bin/pip" install --quiet pyserial pyinstaller

# PyInstaller expects the entry point to be a .py file:
cp src/gEEProgGUI "$WORK/gEEProgGUI.py"

"$VENV/bin/pyinstaller" \
    --noconfirm \
    --clean \
    --windowed \
    --name gEEProg \
    --icon "$ROOT/graphics/Icon.icns" \
    --add-data "$ROOT/graphics/Icon.gif:graphics" \
    --paths "$ROOT/src" \
    --osx-bundle-identifier "$BUNDLE_ID" \
    --workpath "$WORK/pyinstaller" \
    --specpath "$WORK" \
    --distpath "$ROOT/dist" \
    "$WORK/gEEProgGUI.py"

# Fill in version and copyright in Info.plist, then re-sign since editing
# the bundle invalidates the signature:
PLIST="dist/gEEProg.app/Contents/Info.plist"
plutil -replace CFBundleShortVersionString -string "$VERSION" "$PLIST"
plutil -replace CFBundleVersion -string "$VERSION" "$PLIST"
plutil -replace NSHumanReadableCopyright -string "© 2014 Mark Chilenski. Distributed under the GPL." "$PLIST"
codesign --force --deep --sign - dist/gEEProg.app

rm -f dist/gEEProg.zip
ditto -c -k --keepParent dist/gEEProg.app dist/gEEProg.zip

echo "Built dist/gEEProg.app (version $VERSION)"
