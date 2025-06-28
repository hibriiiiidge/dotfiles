#!/usr/bin/env bash
# set -euo pipefail

#-------------------------------
# 1) 基本ツール（ca-certificates など）
#-------------------------------
sudo apt-get update -y \
  && sudo apt-get install -y --no-install-recommends \
       ca-certificates

#-------------------------------
# 2) dotfiles をシンボリックリンク
#-------------------------------
cd ~
ln -fs ~/dotfiles/.zshrc      .
ln -fs ~/dotfiles/.vimrc      .
ln -fs ~/dotfiles/.gitconfig  .
ln -fs ~/dotfiles/.zpreztorc  .

#-------------------------------
# 3) Git 補完スクリプト
#-------------------------------
mkdir -p ~/.zsh/completions
cd     ~/.zsh/completions

if ! command -v wget &>/dev/null; then
  sudo apt-get update -y \
    && sudo apt-get install -y --no-install-recommends wget
fi

wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
wget -O _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

#-------------------------------
# 4) zsh-autosuggestions
#-------------------------------
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

#-------------------------------
# 5) GitHub CLI (gh)
#-------------------------------
if ! command -v gh &>/dev/null; then
  # 公式 GPG キーを登録
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg

  # APT リポジトリを追加
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
        https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

  # gh をインストール
  sudo apt-get update -y \
    && sudo apt-get install -y --no-install-recommends gh
fi

#-------------------------------
# 6) Prezto フレームワーク
#-------------------------------
git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
