if test -e ~/.config/fish/config.fish.local
  source ~/.config/fish/config.fish.local
end

if test -e ~/.rbenv/bin/rbenv
  status --is-interactive; and ~/.rbenv/bin/rbenv init - fish | source
end
