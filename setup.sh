HOME=~
SOURCE_DIR=src
DOTFILE_PREFIX=dot

for source in $SOURCE_DIR/*; do
  filename=$source
  filename=${filename#$SOURCE_DIR/}
  filename=${filename#$DOTFILE_PREFIX}

  original_fullpath=`realpath $source`
  symlink_fullpath=$HOME/$filename

  if [ -L $symlink_fullpath ]; then
    if [ `readlink $symlink_fullpath` = $original_fullpath ]; then
      echo "$symlink_fullpath\t=>\t$original_fullpath"
    else
      echo "\033[31mSymlink already exists: $symlink_fullpath\033[m"
    fi
  elif [ -e $symlink_fullpath ]; then
    echo "\033[31mFile already exists: $symlink_fullpath\033[m"
  else
    echo "\033[32m$symlink_fullpath\t=>\t$original_fullpath\033[m"
    ln -s $original_fullpath $symlink_fullpath
  fi
done
