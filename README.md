# ghostty-tab-color

Automatically applies distinct premium dark themes to each [Ghostty](https://ghostty.org) tab so you can tell them apart at a glance.

Instead of just shifting the hue of your background, this version applies complete curated color palettes (background, foreground, cursor, and the full 16 ANSI colors) atomically using terminal escape sequences.

## Features

- **Dynamic Theme Cycling**: Cycles through 9 visually distinct premium dark themes (like Catppuccin, Nord, Gruvbox, Everforest, Tokyo Night) based on the tab's TTY slot.
- **Forced Theme Mode**: Force a specific theme for the current tab using `tab-color theme <theme_name>`.
- **Per-Project Themes**: Automatically applies themes when changing directories if a `.config/.tab-theme` file is present.
- **Truecolor Preview List**: Run `tab-color list` to see all available themes rendered with truecolor swatches directly in your terminal.
- **Atomic Operations & Cache**: Caches parsed theme colors in Fish universal variables to keep startup instantaneous, and writes the entire color palette in a single atomic sequence.

## Requirements

- [Ghostty](https://ghostty.org)
- [fish shell](https://fishshell.com)
- `bash` (ships with macOS)

## Install

```bash
git clone https://github.com/meghanto/ghostty-tab-color.git
cd ghostty-tab-color
bash install.sh
```

Open a new Ghostty tab to see it take effect.

## Usage

```fish
tab-color                   # Toggle tab color cycling on/off
tab-color on                # Enable dynamic theme cycling
tab-color off               # Disable theme overrides (reverts to default)
tab-color status            # Show current theme and application status
tab-color list              # List all 20 premium dark themes with color previews
tab-color random            # Apply a random theme to the current tab
tab-color theme <name>      # Force a specific theme (e.g., catppuccin, nord, gruvbox)
```

### Per-Project Themes

Create a `.config/.tab-theme` file in any directory with the subcommand you want to run. For example:
```bash
# In your project's .config/.tab-theme:
theme tokyonight
```
When you `cd` into that directory, fish will automatically apply the Tokyo Night theme to that tab.

## Uninstall

```bash
rm ~/.config/fish/ghostty_tab_theme.sh
rm ~/.config/fish/conf.d/ghostty-tab-color.fish
rm ~/.config/fish/functions/tab-color.fish
rm ~/.config/fish/functions/_tab_color_render_line.fish
rm ~/.config/fish/functions/_ghostty_tab_chpwd.fish
rm ~/.config/fish/completions/tab-color.fish
```

## Available Themes

Run `tab-color list` in your shell to preview:
- `london_soho_night`
- `solarized`
- `synthwave_everything`
- `zenbones_dark`
- `nightfox`
- `nord`
- `catppuccin`
- `gruvbox`
- `everforest`
- `tokyonight`
- `rosepine`
- `dracula`
- `pnevma`
- `rippedcasts`
- `kanso_ink`
- `kanso_mist`
- `guezwhoz`
- `adwaita_dark`
- `monokai_pro_octagon`
- `monokai_soda`

## Theme Credits & Attribution

This project wouldn't look as good without the incredible color palettes designed by the community. Here are the original sources for the themes included:

### Standalone Themes
- **[Catppuccin](https://github.com/catppuccin/catppuccin)**
- **[Tokyo Night](https://github.com/folke/tokyonight.nvim)**
- **[Nord](https://github.com/nordtheme/nord)**
- **[Gruvbox](https://github.com/morhetz/gruvbox)**
- **[Solarized](https://github.com/altercation/ethanschoonover-solarized)**
- **[Rosé Pine](https://github.com/rose-pine/rose-pine-theme)**
- **[Dracula](https://github.com/dracula/dracula-theme)**
- **[Everforest](https://github.com/sainnhe/everforest)**
- **[Zenbones](https://github.com/mcchrish/zenbones.nvim)**
- **[Nightfox](https://github.com/EdenEast/nightfox.nvim)**
- **[Monokai Pro](https://monokai.pro)**

### Ported Terminal Schemes
These themes are sourced or adapted from the **[iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes)** repository:
- **Guezwhoz** (by Egor Lem)
- **Pnevma** (by baskerville)
- **London Soho Night** (by Scott Matthews)
- **Rippedcasts**
- **Synthwave Everything**
- **Kanso Ink & Kanso Mist**
- **Adwaita Dark**
- **Monokai Soda**

