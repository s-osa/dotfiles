setopt IGNORE_EOF
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS

export HISTFILE=$HOME/.zhistory
export HISTSIZE=100000
export SAVEHIST=100000

function history-search-peco() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N history-search-peco
bindkey '^R' history-search-peco

repo () {
  repository="$( ghq list | peco )"
  if [[ -n $repository ]]; then
    fullpath="$( ghq root )/$repository"
    cd $fullpath
  else
    echo "No repository selected."
  fi
}

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="~/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

eval "$(starship init zsh)"
