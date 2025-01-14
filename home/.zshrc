setopt IGNORE_EOF

function history-search-peco() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N history-search-peco
bindkey '^R' history-search-peco

repo () {
  cd "$( ghq list --full-path | peco)"
}
