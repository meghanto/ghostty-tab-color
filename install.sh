#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FISH_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/fish"

echo "Installing ghostty-tab-color..."

mkdir -p "$FISH_CONF/conf.d" "$FISH_CONF/functions" "$FISH_CONF/completions"

cp "$SCRIPT_DIR/ghostty_tab_theme.sh" "$FISH_CONF/ghostty_tab_theme.sh"
chmod +x "$FISH_CONF/ghostty_tab_theme.sh"

cp "$SCRIPT_DIR/fish/ghostty-tab-color.fish" "$FISH_CONF/conf.d/ghostty-tab-color.fish"
cp "$SCRIPT_DIR/fish/functions/tab-color.fish" "$FISH_CONF/functions/tab-color.fish"
cp "$SCRIPT_DIR/fish/functions/_tab_color_render_line.fish" "$FISH_CONF/functions/_tab_color_render_line.fish"
cp "$SCRIPT_DIR/fish/functions/_ghostty_tab_chpwd.fish" "$FISH_CONF/functions/_ghostty_tab_chpwd.fish"
cp "$SCRIPT_DIR/fish/completions/tab-color.fish" "$FISH_CONF/completions/tab-color.fish"

echo "Done. Open a new Ghostty tab to see it take effect."
echo "Use 'tab-color' or 'tab-color [on|off|toggle|status|list|random]' to control tab tinting."
