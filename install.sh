#!/usr/bin/env bash
set -euo pipefail

# .zshrc
cd ~/
ln -fs ~/dotfiles/.zshrc .

# powerline_shell
pip install powerline_shell

# z
git clone git@github.com:rupa/z.git ~/z

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# git completions
mkdir -p ~/.zsh/completions
cd ~/.zsh/completions
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
wget -O _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
