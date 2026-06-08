# Disable standard file completions for the tab-color command
complete -c tab-color -f

# Primary subcommand suggestions (suggested only as the first argument)
complete -c tab-color -n "not __fish_seen_subcommand_from on off toggle theme status list random" -a on -d "Enable dynamic theme cycling"
complete -c tab-color -n "not __fish_seen_subcommand_from on off toggle theme status list random" -a off -d "Disable theme overrides (revert to Kanso Ink)"
complete -c tab-color -n "not __fish_seen_subcommand_from on off toggle theme status list random" -a toggle -d "Toggle dynamic theme cycling"
complete -c tab-color -n "not __fish_seen_subcommand_from on off toggle theme status list random" -a theme -d "Force a specific theme"
complete -c tab-color -n "not __fish_seen_subcommand_from on off toggle theme status list random" -a status -d "Show active theme and state"
complete -c tab-color -n "not __fish_seen_subcommand_from on off toggle theme status list random" -a list -d "List all available themes"
complete -c tab-color -n "not __fish_seen_subcommand_from on off toggle theme status list random" -a random -d "Apply a random visually distinct theme"

# Theme suggestions (suggested ONLY if the 'theme' subcommand has been supplied)
set -l _valid_themes catppuccin tokyonight nord gruvbox solarized rosepine dracula everforest pnevma rippedcasts \
                    zenbones_dark synthwave_everything kanso_ink kanso_mist guezwhoz adwaita_dark \
                    london_soho_night monokai_pro_octagon monokai_soda nightfox

for t in $_valid_themes
    # Beautify description by replacing underscores with spaces and capitalizing
    set -l _theme_desc "Switch to "(echo "$t" | tr '_' ' ' | sed -E 's/\b([a-z])/\U\1/g')
    complete -c tab-color -n "__fish_seen_subcommand_from theme" -a "$t" -d "$_theme_desc"
    # Also suggest friendly dashed formats in completions so they are discoverable
    set -l _dashed_t (string replace -a '_' '-' "$t")
    if test "$t" != "$_dashed_t"
        complete -c tab-color -n "__fish_seen_subcommand_from theme" -a "$_dashed_t" -d "$_theme_desc"
    end
end
