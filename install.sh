#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FISH_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/fish"

echo "Installing ghostty-tab-color..."

mkdir -p "$FISH_CONF/conf.d"

cp "$SCRIPT_DIR/ghostty_tab_tint.sh" "$FISH_CONF/ghostty_tab_tint.sh"
chmod +x "$FISH_CONF/ghostty_tab_tint.sh"

cp "$SCRIPT_DIR/fish/ghostty-tab-color.fish" "$FISH_CONF/conf.d/ghostty-tab-color.fish"

echo "Done. Open a new Ghostty tab to see it take effect."
