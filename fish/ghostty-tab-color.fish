if status is-interactive; and test "$ghostty_tab_color" != disabled; and tty -s; and test "$TERM_PROGRAM" = ghostty -o -n "$GHOSTTY_RESOURCES_DIR"
    set -l _tty (tty)
    
    # 1. Determine active theme (either forced theme lock or cycle based on TTY index)
    set -l _theme ""
    if set -q _GHOSTTY_FORCED_THEME; and test -n "$_GHOSTTY_FORCED_THEME"
        set _theme "$_GHOSTTY_FORCED_THEME"
    else
        set -l _tty_num (echo "$_tty" | grep -o '[0-9]*$')
        if test -n "$_tty_num"
            # Cycle through 9 visually distinct themes
            set -l _slot_idx (math "$_tty_num % 9 + 1")
            # Map slot index to name
            switch "$_slot_idx"
                case 1; set _theme "london_soho_night"
                case 2; set _theme "solarized"
                case 3; set _theme "synthwave_everything"
                case 4; set _theme "zenbones_dark"
                case 5; set _theme "nightfox"
                case 6; set _theme "nord"
                case 7; set _theme "catppuccin"
                case 8; set _theme "gruvbox"
                case 9; set _theme "everforest"
            end
        end
    end
    
    if test -n "$_theme"
        # 2. Skip if this TTY already has this theme applied (nesting check)
        if not set -q _GHOSTTY_BACKGROUND_TINTED_TTY; or test "$_GHOSTTY_BACKGROUND_TINTED_TTY" != "$_tty"; or not set -q _GHOSTTY_BACKGROUND_TINTED_THEME; or test "$_GHOSTTY_BACKGROUND_TINTED_THEME" != "$_theme"
            
            # 3. Dynamic universal cache variable lookup
            set -l _cache_var "ghostty_theme_cache_$_theme"
            if not set -q $_cache_var
                set -l _colors (bash ~/.config/fish/ghostty_tab_theme.sh "$_theme" 2>/dev/null)
                if test -n "$_colors"
                    set -U $_cache_var (string split " " "$_colors")
                end
            end
            
            # 4. Apply full palette
            set -l _colors_list $$_cache_var
            if test (count $_colors_list) -eq 19
                set -l _bg $_colors_list[1]
                set -l _fg $_colors_list[2]
                set -l _cursor $_colors_list[3]
                
                # Foreground, Background, and Cursor
                set -l _seq (printf '\033]10;%s\007\033]11;%s\007\033]12;%s\007' $_fg $_bg $_cursor)
                
                # ANSI 0 - 15 Palette Colors
                for i in (seq 0 15)
                    set -l _color_idx (math "$i + 4")
                    set _seq "$_seq"(printf '\033]4;%d;%s\007' $i $_colors_list[$_color_idx])
                end
                
                # Single atomic write to the terminal
                echo -n -e "$_seq" >/dev/tty
                
                # Mark environment state for nested shells
                set -gx _GHOSTTY_BACKGROUND_TINTED_TTY "$_tty"
                set -gx _GHOSTTY_BACKGROUND_TINTED_THEME "$_theme"
            end
        end
    end
end

