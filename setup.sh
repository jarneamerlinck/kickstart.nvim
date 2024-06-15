#!/bin/bash

# Initial Setup file for new systems
gitpath=$(pwd)
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
mkdir -p "$HOME/.vim/undodir"
mkdir -p "$HOME/.scripts"
cp "$gitpath/.ignore" "$HOME/.ignore"
ln -s "$gitpath/kickstart" "$HOME/.config/nvim"
# Share system clipboard with unnamedplus



echo "nvim config package requirements"
xargs -a install_requirements.txt sudo apt install -y
