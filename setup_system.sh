#!/bin/bash

source $BASH_IT/bash_it.sh

case "$1" in
  home)
    ;;

  work)
    echo "setting up ~/.gitconfig_local"
    rm -f ~/.gitconfig_local
    printf "[user]\n    email = dwatson@netflix.com\n" > ~/.gitconfig_local
    ;;

  *)
    echo $"Usage: $0 {home|work}"
    exit 1
esac

echo "setup bash-it aliases"
bash-it disable alias all
for i in general git homebrew osx vagrant; do
  bash-it enable alias $i
done

echo "setup bash-it plugins"
bash-it disable plugin all
for i in base dirs docker extract fasd git java osx pyenv python ssh tmux vagrant virtualenv; do
  bash-it enable plugin $i
done

# Use homebrew completion instead
bash-it disable completion all

# Update vim bundles
vim -u $HOME/.vimrc.bundles +BundleInstall +qa
