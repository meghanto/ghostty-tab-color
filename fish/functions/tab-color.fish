function tab-color --description "Toggle ghostty tab background tinting on/off"
    switch "$argv[1]"
        case on
            set -U ghostty_tab_color enabled
            if test "$TERM_PROGRAM" = ghostty
                set -l _slot (math "($(tty | grep -o '[0-9]*$')) % 15 + 1")
                set -l _tint (bash ~/.config/fish/ghostty_tab_tint.sh $_slot 2>/dev/null)
                if test -n "$_tint"
                    printf '\033]11;rgb:%s\007' $_tint >/dev/tty
                end
            end
            echo "Tab color: on"
        case off
            set -U ghostty_tab_color disabled
            if test "$TERM_PROGRAM" = ghostty
                printf '\033]111\007' >/dev/tty
            end
            echo "Tab color: off"
        case toggle ''
            if test "$ghostty_tab_color" = disabled
                tab-color on
            else
                tab-color off
            end
        case '*'
            echo "Usage: tab-color [on|off|toggle]"
            return 1
    end
end
