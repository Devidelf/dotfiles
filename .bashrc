#
# ~/.bashrc
#

[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups
export EDITOR='nvim'
export VISUAL='nvim'

PS1='[\u@\h \W]\$ '

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/Applications:$PATH"

bind "set completion-ignore-case on"

alias ll='ls -la --color=auto'
alias cd..='cd ..'
alias df='df -h'
alias pacman='sudo pacman --color auto'
alias update-fc='sudo fc-cache -fv'
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias kp="keepassxc-cli"
alias agent="eval `ssh-agent`"
alias agenths="ssh-add ~/.ssh/id_rsa_hs"
alias homeserver="ssh-add ~/.ssh/id_rsa_hs && ssh devi@192.168.178.29"
alias clotheme="cd ~/public_html/clotheme.test"
alias xc="xclip -selection clipboard"
eval "$(starship init bash)"

macchina

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
