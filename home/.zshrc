setopt IGNORE_EOF

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
