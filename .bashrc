# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias reboot='doas reboot'
alias poweroff='doas poweroff'

alias cfg='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dgnd='dragon-drop -a -x'

export CDPATH=".:.."
export PATH="$PATH:/home/$USER/.local/bin:$HOME/.cargo/bin"

PS1='[\u@\h \W]\$ '

#eval "$(direnv hook bash)"
alias shot='scrot -s /tmp/shot.png && xclip -selection clipboard -t image/png -i /tmp/shot.png && rm /tmp/shot.png'
alias sudo="doas"

alias dgnd='dragon-drop -a -x'
