function tab-color --description "Toggle or force a specific ghostty tab theme"
    # Supported premium dark themes (canonical names use underscores)
    set -l _valid_themes catppuccin tokyonight nord gruvbox solarized rosepine dracula everforest pnevma rippedcasts \
                        zenbones_dark synthwave_everything kanso_ink kanso_mist guezwhoz adwaita_dark \
                        london_soho_night monokai_pro_octagon monokai_soda nightfox
    
    if test (count $argv) -eq 0
        # Simple toggle
        if test "$ghostty_tab_color" = disabled
            tab-color on
        else
            tab-color off
        end
        return 0
    end

    switch "$argv[1]"
        case on
            set -U ghostty_tab_color enabled
            # Remove any forced locks and reset cache/state tracking to force dynamic cycle
            set -e _GHOSTTY_FORCED_THEME
            set -e _GHOSTTY_BACKGROUND_TINTED_TTY
            set -e _GHOSTTY_BACKGROUND_TINTED_THEME
            for t in $_valid_themes
                set -e "ghostty_theme_cache_$t"
            end
            
            # Re-apply using hook
            source ~/.config/fish/conf.d/ghostty-tab-color.fish
            echo "Tab color: enabled (cycling themes)"

        case off
            set -U ghostty_tab_color disabled
            # Reset environment locks
            set -e _GHOSTTY_FORCED_THEME
            set -e _GHOSTTY_BACKGROUND_TINTED_TTY
            set -e _GHOSTTY_BACKGROUND_TINTED_THEME
            
            # Unified reset sequence:
            # - OSC 110: Reset Foreground
            # - OSC 111: Reset Background
            # - OSC 112: Reset Cursor
            # - OSC 104: Reset Full 256 ANSI Palette (reverts all theme overrides instantly!)
            if test "$TERM_PROGRAM" = ghostty -o -n "$GHOSTTY_RESOURCES_DIR"; and tty -s
                set -l _reset_seq (printf '\033]110\007\033]111\007\033]112\007\033]104\007')
                echo -n -e "$_reset_seq" >/dev/tty
            end
            echo "Tab color: disabled (restored Kanso Ink)"

        case toggle
            if test "$ghostty_tab_color" = disabled
                tab-color on
            else
                tab-color off
            end

        case status
            set -l _mode "disabled"
            set -l _theme "(none)"
            set -l _source "—"
            if test "$ghostty_tab_color" != disabled
                set _mode "enabled"
                if set -q _GHOSTTY_FORCED_THEME; and test -n "$_GHOSTTY_FORCED_THEME"
                    set _theme "$_GHOSTTY_FORCED_THEME"
                    set _source "forced"
                else if set -q _GHOSTTY_BACKGROUND_TINTED_THEME; and test -n "$_GHOSTTY_BACKGROUND_TINTED_THEME"
                    set _theme "$_GHOSTTY_BACKGROUND_TINTED_THEME"
                    set _source "auto-cycled"
                end
            end
            echo "Tab color:  $_mode"
            echo "Theme:      $_theme"
            echo "Source:     $_source"
            if tty -s
                echo "TTY:        "(tty)
            end

        case list
            set -l _active ""
            if set -q _GHOSTTY_FORCED_THEME; and test -n "$_GHOSTTY_FORCED_THEME"
                set _active "$_GHOSTTY_FORCED_THEME"
            else if set -q _GHOSTTY_BACKGROUND_TINTED_THEME; and test -n "$_GHOSTTY_BACKGROUND_TINTED_THEME"
                set _active "$_GHOSTTY_BACKGROUND_TINTED_THEME"
            end
            set -l _rotation london_soho_night solarized synthwave_everything zenbones_dark nightfox nord catppuccin gruvbox everforest
            printf '\n \033[1mAuto-cycle rotation\033[0m\n\n'
            for t in $_rotation
                _tab_color_render_line $t "$_active"
            end
            printf '\n \033[1mAdditional themes\033[0m (tab-color theme <name>)\n\n'
            for t in $_valid_themes
                contains $t $_rotation; or _tab_color_render_line $t "$_active"
            end
            echo ""

        case random
            # Select from all 20 valid themes
            set -l _rand_idx (random 1 (count $_valid_themes))
            set -l _chosen_theme $_valid_themes[$_rand_idx]
            
            # Apply it exactly like a forced theme
            set -U ghostty_tab_color enabled
            set -gx _GHOSTTY_FORCED_THEME "$_chosen_theme"
            set -e _GHOSTTY_BACKGROUND_TINTED_TTY
            set -e _GHOSTTY_BACKGROUND_TINTED_THEME
            
            source ~/.config/fish/conf.d/ghostty-tab-color.fish
            echo "Randomly selected theme: $_chosen_theme"

        case theme
            if test (count $argv) -lt 2
                echo "Error: Please specify a theme name."
                echo "Available themes: $_valid_themes"
                return 1
            end
            
            # Normalize theme name to lowercase and convert dashes to underscores
            set -l _requested_theme (echo "$argv[2]" | tr '[:upper:]' '[:lower:]' | tr '-' '_')
            
            if contains "$_requested_theme" $_valid_themes
                set -U ghostty_tab_color enabled
                # Force specific theme in the current tab's environment
                set -gx _GHOSTTY_FORCED_THEME "$_requested_theme"
                set -e _GHOSTTY_BACKGROUND_TINTED_TTY
                set -e _GHOSTTY_BACKGROUND_TINTED_THEME
                
                # Apply immediately
                source ~/.config/fish/conf.d/ghostty-tab-color.fish
                echo "Forced tab theme: $_requested_theme"
            else
                echo "Error: Unknown theme '$_requested_theme'"
                echo "Available themes: $_valid_themes"
                return 1
            end

        case '*'
            echo "Usage: tab-color [on|off|toggle|status|list|random] or tab-color theme [theme_name]"
            return 1
    end
end
