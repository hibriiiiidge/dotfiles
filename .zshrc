# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

########################################
# 環境変数
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# Add fpath
fpath+=~/.zfunc
fpath=(~/.zsh/completion $fpath)

########################################
# 補完
# 補完機能を有効にする
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit -i
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# vim:set ft=zsh:

# Add poetry command
if [[ ${OSTYPE} =~ 'darwin*' ]]; then
  export PATH="$PATH:/Users/yamasaki/.local/bin"
else
  export PATH="$PATH:/home/yamazaki/.poetry/bin"
fi

# Add z command
. ~/z/z.sh
alias j=z

# Add fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add powerline-shell
function powerline_precmd() {
    PS1="
$(powerline-shell --shell zsh $?)
$ "
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

# Add Rust configuration
export PATH="~/.cargo/bin:$PATH"

# Add gamess gms command
export PATH="/Applications/gamess:$PATH"

# Add devcontainer configuration
if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent
   fi
   eval `cat $HOME/.ssh/ssh-agent`
fi

# Add bash_completion command configuration
complete -C '/usr/local/bin/aws_completer' aws

# Add AWS profile
export AWS_PROFILE=default
export ACCOUNT_ID=
export ECR_ADDRESS=${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com

# Add zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# ADD PYTEST_ADDOPTS
export PYTEST_ADDOPTS='-v --disable-warnings --ff'

# Add luigi_completion
_luigi_completion(){
    COMPREPLY=()
    local args1=`cat .luigi_completion | grep "^module\:" | sed s/module\:// | tr '\n' ' '`
    local args2=`cat .luigi_completion | grep "^parameter\:" | sed s/parameter\:// | tr '\n' ' '`
    if [ -e .luigi_completion ] && [ "${COMP_CWORD}" -gt 1 ] ; then
        case "$COMP_CWORD" in
            2)
                COMPREPLY=( `compgen -W "$args1" -- ${COMP_WORDS[COMP_CWORD]} `);;
            *)
                COMPREPLY=( `compgen -W "$args2" -- ${COMP_WORDS[COMP_CWORD]} `);;
        esac
    fi
    return 0
}
complete -o default -o filenames -o bashdefault -F _luigi_completion python luigi

# Add ssh-agent configuration
if "${REMOTE_CONTAINERS}" ; then

else
  ssh-add -K &> /dev/null
fi

# Add gh completion
gh -version &> /dev/null
if [ $? -eq 0 ] ; then
  eval "$(gh completion -s zsh)"
fi

# Add path to cargo
if [ -e ~/.cargo/env ] ; then
  source ~/.cargo/env
fi
