function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
  set -l pwd (echo -n $PWD | sed "s/^$home_escaped/~/" | sed 's/ /%20/g')

  # SSH
  test $SSH_TTY
  and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
  test "$USER" = 'root'
  and echo (set_color red)"#"

  # Main
  set -l prompt_color
  if test $last_status -eq 0
    set prompt_color green
  else
    set prompt_color red
  end

  printf "%s%s%s " (set_color cyan) $pwd\n (set_color $prompt_color)'❯❯❯'

  set_color normal
end
