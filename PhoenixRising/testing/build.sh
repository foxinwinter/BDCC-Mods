#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

# works whether src is in ./mod/PhoenixRising/ or ./
src="mod/PhoenixRising"
[ ! -d "$src" ] && src="."

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

find "$src" -type f \( -name '*.gd' -o -name '*.tscn' -o -name '*.json' \) | while read -r f; do
    rel="${f#"$src"}"
    rel="${rel#/}"
    mkdir -p "$tmp/Modules/PhoenixRising/$(dirname "$rel")"
    cp "$f" "$tmp/Modules/PhoenixRising/$rel"
done

cd "$tmp"
zip -r "/nyaa/coding/projects/bdcc2/PhoenixRising.zip" . >/dev/null

mkdir -p ~/.local/share/godot/app_userdata/BDCC/mods
cp "/nyaa/coding/projects/bdcc2/PhoenixRising.zip" ~/.local/share/godot/app_userdata/BDCC/mods/PhoenixRising.zip

echo "Built and installed PhoenixRising.zip"
