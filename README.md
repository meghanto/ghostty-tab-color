# ghostty-tab-color

Automatically tints each [Ghostty](https://ghostty.org) tab a distinct color so you can tell them apart at a glance — no title-reading required.

Each tab gets a unique background derived from your current theme's background color via a hue rotation in [OKLCH](https://oklch.com/) (perceptually uniform), so all tints have equal perceived luminosity and stay in harmony with your theme. Works on both dark and light themes.

![15 Ghostty tabs each with a distinct subtle background tint](.github/preview.png)

## How it works

- Reads your Ghostty background color directly from your config
- Converts it to OKLCH and rotates the hue ±90° in 15 steps (~12.86° apart)
- Reduces chroma by 1% per step away from center, keeping extreme hues softer
- Rescales linear RGB to match the original background's luminance (Y) exactly
- Assigns each tab a slot via its TTY number — deterministic and stable for the tab's lifetime
- Applies the tint via OSC 11, which Ghostty scopes per terminal session

## Requirements

- [Ghostty](https://ghostty.org)
- [fish shell](https://fishshell.com)
- `bash` and `awk` (both ship with macOS)

## Install

```bash
git clone https://github.com/meghanto/ghostty-tab-color.git
cd ghostty-tab-color
bash install.sh
```

Open a new Ghostty tab to see it take effect.

## Usage

```fish
tab-color         # toggle on/off
tab-color on      # enable tinting
tab-color off     # disable tinting (resets current tab to default background)
```

The setting persists across sessions via a fish universal variable.

## Uninstall

```bash
rm ~/.config/fish/ghostty_tab_tint.sh
rm ~/.config/fish/conf.d/ghostty-tab-color.fish
rm ~/.config/fish/functions/tab-color.fish
```

## Tuning

All parameters are in `ghostty_tab_tint.sh`:

| Parameter | Default | Effect |
|-----------|---------|--------|
| Hue range | ±90° | Total arc of color spread |
| Steps | 15 | Number of distinct tab colors before repeating |
| Chroma taper | 1% per step | How much softer the extreme hues are |

To change the number of steps, also update the modulo in `fish/ghostty-tab-color.fish`:
```fish
set -l _slot (math "($(tty | grep -o '[0-9]*$')) % 15 + 1")
#                                                        ^^ change this
```
