# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Alias
alias rs='rails s'
alias rc='rails c'
alias e='exit'
alias dc='docker-compose'
alias d='docker'
alias gpc='gh pr create -w'
alias oc='open -a 'Google Chrome' index.html'

# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# VSCode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/.poetry/bin:$PATH"
export LSCOLORS=gxfxcxdxbxegedabagacad
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:./node_modules/.bin

# function
function gdl() {
  git branch --merged | grep -vE '^\*|master$|develop$' | xargs -I % git branch -d %
}

# Remote container Add ssh-agent configuration
if ! "${REMOTE_CONTAINERS}" ; then
  sudo ssh-add -K &> /dev/null
fi

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
