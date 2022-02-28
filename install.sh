#!/usr/bin/env bash
set -euo pipefail

# .zshrc
cd ~/
ln -fs ~/dotfiles/.zshrc .

# .vimrc
cd ~/
ln -fs ~/dotfiles/.vimrc .

# powerline_shell
pip install powerline_shell

# z
git clone git@github.com:rupa/z.git ~/z

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
apt install locales-all

# git completions
mkdir -p ~/.zsh/completions
cd ~/.zsh/completions
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
wget -O _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
