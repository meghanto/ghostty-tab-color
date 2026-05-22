if test "$TERM_PROGRAM" = ghostty
    set -l _slot (math "($(tty | grep -o '[0-9]*$')) % 15 + 1")
    set -l _tint (bash ~/.config/fish/ghostty_tab_tint.sh $_slot 2>/dev/null)
    if test -n "$_tint"
        printf '\033]11;rgb:%s\007' $_tint >/dev/tty
    end
end
