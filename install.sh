#!/usr/bin/env bash
# set -euo pipefail

apk update && apk add --no-cache ca-certificates

# .zshrc
cd ~/
ln -fs ~/dotfiles/.zshrc .

# .vimrc
cd ~/
ln -fs ~/dotfiles/.vimrc .

# .gitconfig
cd ~/
ln -fs ~/dotfiles/.gitconfig .

# .zpreztorc
cd ~/
ln -fs ~/dotfiles/.zpreztorc .

# git completions
mkdir -p ~/.zsh/completions
cd ~/.zsh/completions
wget --version &> /dev/null
if [ $? -ne 0 ] ; then
  apk update && apk add --no-cache --no-install-recommends wget
fi
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
wget -O _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# install gh
gh -version &> /dev/null
if [ $? -ne 0 ] ; then
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --no-tty --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apk/sources.list.d/github-cli.list > /dev/null \
    && apk update \
    && apk add --no-cache --no-install-recommends gh
fi

# zprezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
