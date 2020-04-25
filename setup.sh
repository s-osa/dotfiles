#!/bin/bash

FILES=$(cat << FILES
.ideavimrc
.config
.gitconfig
.gitconfig.agrigate
.gitignore
.tmux.conf
.vimrc
FILES
)

COLOR_RED=$(printf "\e[31m")
COLOR_GREEN=$(printf "\e[32m")
COLOR_YELLOW=$(printf "\e[33m")
COLOR_RESET=$(printf "\e[m")

# Create symlink

for file in $FILES
do
  link_destination_path=$PWD/home/$file
  link_source_path=$HOME/$file

  if [ ! -e $link_destination_path ]; then
    echo "${COLOR_RED}Error:    ${link_destination_path} does not exist!${COLOR_RESET}"
  elif [ ! -e $link_source_path ]; then
    echo "${COLOR_GREEN}Symlink:  ${link_source_path} => ${link_destination_path}${COLOR_RESET}"
    ln -s $link_destination_path $link_source_path
  elif [ ! -L $link_source_path ]; then
    echo "${COLOR_YELLOW}Conflict: ${link_source_path} already exists (not changed)${COLOR_RESET}"
  elif [ $(readlink $link_source_path) != $link_destination_path ]; then
    current_destination_path=$(readlink $link_source_path)
    echo "${COLOR_YELLOW}Conflict: ${link_source_path} already exists (not changed)${COLOR_RESET}"
  else
    echo "Existing: ${link_source_path} => ${link_destination_path}"
  fi
done

# Copy dummy local files if not exists

DUMMY_FILES=$(cat << FILES
.gitconfig.local
FILES
)

for file in $DUMMY_FILES
do
  dummy_file_path=$PWD/home/$file
  local_file_path=$HOME/$file

  if [ ! -e $dummy_file_path ]; then
    echo "${COLOR_RED}Error:    ${dummy_file_path} does not exist!${COLOR_RESET}"
  elif [ ! -e $local_file_path ]; then
    echo "${COLOR_GREEN}Generate:  ${local_filelink_source_path} => ${link_destination_path}${COLOR_RESET}"
    cp $dummy_file_path $local_file_path
  fi
done

exit 0
