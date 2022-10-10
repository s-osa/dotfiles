#!/bin/bash

TEXT_BOLD=$(printf "\e[1m")
TEXT_RED=$(printf "\e[31m")
TEXT_GREEN=$(printf "\e[32m")
TEXT_YELLOW=$(printf "\e[33m")
TEXT_RESET=$(printf "\e[m")

# Create symlinks to the config files

FILES=$(cat << FILES
.gitconfig
.gitconfig.agrigate
.gitignore
.ideavimrc
.tmux.conf
.vimrc
.config/fish/functions
.config/karabiner/karabiner.json
FILES
)

echo "${TEXT_BOLD}=== Generate symlinks${TEXT_RESET}"

for file in $FILES
do
  link_destination_path=$PWD/home/$file
  link_source_path=$HOME/$file

  if [ $(dirname $file) != "." ] ; then
    mkdir -p $(dirname $link_source_path)
  fi

  if [ ! -e $link_destination_path ]; then
    echo "${TEXT_RED}Error:    ${link_destination_path} does not exist!${TEXT_RESET}"
  elif [ ! -e $link_source_path ]; then
    echo "${TEXT_GREEN}Symlink:  ${link_source_path} => ${link_destination_path}${TEXT_RESET}"
    ln -s $link_destination_path $link_source_path
  elif [ ! -L $link_source_path ]; then
    echo "${TEXT_YELLOW}Conflict: ${link_source_path} already exists (not changed)${TEXT_RESET}"
  elif [ $(readlink $link_source_path) != $link_destination_path ]; then
    current_destination_path=$(readlink $link_source_path)
    echo "${TEXT_YELLOW}Conflict: ${link_source_path} already exists (not changed)${TEXT_RESET}"
  else
    echo "Existing: ${link_source_path} => ${link_destination_path}"
  fi
done

# Generate skeleton files for local config

SKELETON_FILES=$(cat << FILES
.gitconfig.local
FILES
)

echo "${TEXT_BOLD}=== Generate skeleton files${TEXT_RESET}"

for file in $SKELETON_FILES
do
  skeleton_file_path=$PWD/home/$file
  local_file_path=$HOME/$file

  if [ ! -e $skeleton_file_path ]; then
    echo "${TEXT_RED}Error:    Source file ${skeleton_file_path} does not exist!${TEXT_RESET}"
  elif [ ! -e $local_file_path ]; then
    echo "${TEXT_GREEN}Generate: ${link_destination_path}${TEXT_RESET}"
    cp $skeleton_file_path $local_file_path
  else
    echo "Existing: ${local_file_path}"
  fi
done

exit 0
