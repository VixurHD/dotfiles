#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export PATH="$PATH:/home/$USER/.local/bin:$HOME/.cargo/bin"

PS1='[\u@\h \W]\$ '

alias cfg='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

snapshot() {
    local SAVELESS_DIR=$(pwd)

    # Ця "if" потрібна щоб у штани не накласти
    # Можна видвлити. Щоби стало доступним для всіх директорї
    local ALLOWED=("$HOME/Test" "$HOME/tmp")
    if [[ " ${ALLOWED[*]} " != *" $SAVELESS_DIR "* ]]; then
        echo "Эта директория не доступна для сохранения"
    else
        local SAVE_DIR="$HOME/Saves"

        local DATE=$(date +"%Y-%m-%d_%H-%M-%S")
        local NAME="${1:+${1}_}${DATE}"    # Если есть аргумент — "имя_дата", иначе просто "дата"
        local ARCHIVE="$SAVE_DIR/${NAME}.tar.gz"

        mkdir -p "$SAVE_DIR"
        tar -czf "$ARCHIVE" -C "$SAVELESS_DIR" .

        echo "Збережено: $ARCHIVE"
    fi
}
