function fish_prompt --description 'Write out the prompt'
  set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
  set -l pwd (echo -n $PWD | sed "s/^$home_escaped/~/" | sed 's/ /%20/g')

  # SSH
  test $SSH_TTY
  and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
  test "$USER" = 'root'
  and echo (set_color red)"#"

  # Main
  printf "%s%s %s " (set_color cyan) $pwd (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯'
end
