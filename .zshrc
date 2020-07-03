# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=1000

unsetopt autocd beep extendedglob notify
bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle :compinstall filename '/home/devi/.zshrc'
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit

# End of lines added by compinstall

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim 
export VISUAL=/usr/bin/nvim
export TERM=xterm-256color
export KEYTIMEOUT=1

# Alias

alias ls="ls -a -l --color=auto"
alias scz="source ~/.zshrc"
alias nv="nvim"

# GIT Aliases

alias gs="git status"
alias ga="git add ."
alias gc="git commit"

function acp() {
git add .
git commit -m "$1"
git push
}

# Plugins

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Colors

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# Spaceship Prompt Config

SPACESHIP_PROMPT_ADD_NEWLINE="false"
SPACESHIP_USER_SHOW="always"
SPACESHIP_PROMPT_SEPARATE_LINE="false"
SPACESHIP_USER_PREFIX=""
SPACESHIP_DIR_PREFIX=""
SPACESHIP_HOST_SHOW="false"
SPACESHIP_VI_MODE_SHOW="false"
SPACESHIP_VI_MODE_NORMAL="N"
SPACESHIP_VI_MODE_INSERT="I"
SPACESHIP_DIR_SUFFIX=" "
SPACESHIP_PACKAGE_SHOW="false"
SPACESHIP_PHP_SHOW="false"
SPACESHIP_EXEC_TIME_SHOW="false"
SPACESHIP_NODE_SHOW="false"

#Node Version Manager
 
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec
source /usr/share/nvm/init-nvm.sh

#if [ -f /usr/bin/screenfetch ]; then screenfetch; fi


autoload -U promptinit; promptinit
prompt spaceship
