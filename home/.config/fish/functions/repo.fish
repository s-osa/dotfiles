# Defined in - @ line 1
function repo
  set path (ghq list | peco)
  if not test -z $path
    cd (ghq root)/$path
  else
    echo 'No repository selected.'
  end
end
