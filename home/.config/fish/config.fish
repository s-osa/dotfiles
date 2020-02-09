# rbenv
status --is-interactive; and source (rbenv init -|psub)

# nodenv
status --is-interactive; and source (nodenv init -|psub)

# Haskell
status --is-interactive; and bass source "/Users/osa/.ghcup/env"

# Bootstrap installation for fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
