function _ghostty_tab_chpwd --on-variable PWD --description "Apply per-project tab theme from .config/.tab-theme"
    # Only run inside Ghostty interactive sessions
    test "$TERM_PROGRAM" = ghostty -o -n "$GHOSTTY_RESOURCES_DIR"; or return
    status is-interactive; or return

    set -l _theme_file "$PWD/.config/.tab-theme"
    if test -f "$_theme_file"
        set -l _contents (string trim (cat "$_theme_file"))
        if test -n "$_contents"
            # Split contents into arguments and pass to tab-color
            # Supports: on, off, theme [name]
            eval tab-color $_contents
        end
    end
end
