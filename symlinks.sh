#!/usr/bin/env bash

source 'utils.sh'

declare -a DOTFILES_TO_SYMLINK=(
  '.aliases'
  '.functions'
  '.gitconfig'
  '.gitignore_global'
  '.zshrc'
)

link() {
  local sourceFile=$1
  local targetFile=$2

  if [ ! -e "$targetFile" ]; then
    execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
  elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
    print_success "$targetFile → $sourceFile"
  else
    ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
    if answer_is_yes; then
      rm -rf "$targetFile"
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    else
      print_error "$targetFile → $sourceFile"
    fi
  fi
}

main() {
  local i=''
  local sourceFile=''
  local targetFile=''

  for i in ${DOTFILES_TO_SYMLINK[@]}; do
    sourceFile="$(pwd)/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    link $sourceFile $targetFile
  done
}

main
