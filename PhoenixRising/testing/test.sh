#!/usr/bin/env bash
set -uo pipefail

cd "$(dirname "$0")"

./build.sh

# Also build and install CheatMenu
cheatSrc="$(dirname "$0")/../../CheatMenu"
if [ -d "$cheatSrc" ]; then
    tmp=$(mktemp -d)
    trap 'rm -rf "$tmp"' EXIT

    find "$cheatSrc" -type f \( -name '*.gd' -o -name '*.tscn' \) | while read -r f; do
        rel="${f#"$cheatSrc"}"
        rel="${rel#/}"
        mkdir -p "$tmp/Modules/CheatMenu/$(dirname "$rel")"
        cp "$f" "$tmp/Modules/CheatMenu/$rel"
    done

    cd "$tmp"
    zip -r "/nyaa/coding/projects/bdcc2/CheatMenu.zip" . >/dev/null

    mkdir -p ~/.local/share/godot/app_userdata/BDCC/mods
    cp "/nyaa/coding/projects/bdcc2/CheatMenu.zip" ~/.local/share/godot/app_userdata/BDCC/mods/CheatMenu.zip
    echo "Built and installed CheatMenu.zip"
fi

cd "$(dirname "$0")"
/nyaa/games/itch/bdcc/BDCC.x86_64 "$@"
ec=$?

if [ $ec -eq 0 ]; then
    clear
else
    echo
    echo "Exited with status $ec"
fi
