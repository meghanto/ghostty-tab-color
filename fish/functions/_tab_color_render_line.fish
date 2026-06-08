function _tab_color_render_line --description "Render a theme line with truecolor swatches"
    set -l t $argv[1]
    set -l _active $argv[2]

    # Load from cache or compute
    set -l _cache_var "ghostty_theme_cache_$t"
    if not set -q $_cache_var
        set -l _colors (bash ~/.config/fish/ghostty_tab_theme.sh "$t" 2>/dev/null)
        if test -n "$_colors"
            set -U $_cache_var (string split " " "$_colors")
        end
    end
    set -l _c $$_cache_var
    test (count $_c) -ge 2; or return

    # Parse bg hex → RGB
    set -l _bh (string sub -s 2 $_c[1])
    set -l _br (printf '%d' 0x(string sub -s 1 -l 2 $_bh))
    set -l _bgc (printf '%d' 0x(string sub -s 3 -l 2 $_bh))
    set -l _bb (printf '%d' 0x(string sub -s 5 -l 2 $_bh))
    # Parse fg hex → RGB
    set -l _fh (string sub -s 2 $_c[2])
    set -l _fr (printf '%d' 0x(string sub -s 1 -l 2 $_fh))
    set -l _fgc (printf '%d' 0x(string sub -s 3 -l 2 $_fh))
    set -l _fb (printf '%d' 0x(string sub -s 5 -l 2 $_fh))

    # Render: solid bg block │ fg-on-bg text preview
    set -l _swatch (printf '\033[48;2;%d;%d;%dm    \033[38;2;%d;%d;%dm Aa \033[0m' $_br $_bgc $_bb $_fr $_fgc $_fb)
    set -l _marker ""
    if test "$t" = "$_active"
        set _marker " ← active"
    end
    printf '  %s  %-25s%s\n' "$_swatch" "$t" "$_marker"
end
