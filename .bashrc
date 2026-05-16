#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export PATH="$PATH:/home/$USER/.local/bin:$HOME/.cargo/bin"
[[ -z "$VAR" ]] && export SNAPSHOTABLE_PATH="$HOME/Test:$HOME/tmp"

PS1='[\u@\h \W]\$ '

alias cfg='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

snapshot() {
    local SAVELESS_DIR=$(pwd)

    # Ця "if" потрібна щоб у штани не накласти
    # Можна видвлити. Щоби стало доступним для всіх директорї
    local IFS=':'
    local -a ALLOWED
    read -r -a ALLOWED <<< "$SNAPSHOTABLE_PATH"

    if ! printf '%s\n' "${ALLOWED[@]}" | grep -qxF "$SAVELESS_DIR"; then
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

pick() {
    local PICKED_FILE=$(find ~/Saves/ -mindepth 1 -maxdepth 1 | xargs -I{} basename {} | fzf --height 10 --no-border --layout=reverse --no-info --prompt='> ')
    local BACKUPED_DIR="$HOME/${PICKED_FILE%.tar.gz}"
    mkdir $BACKUPED_DIR
    sudo mount -t tmpfs -o size=1g tmpfs $BACKUPED_DIR
    export SNAPSHOTABLE_PATH="$SNAPSHOTABLE_PATH:$BACKUPED_DIR"
    tar -xvf $HOME/Saves/$PICKED_FILE -C $BACKUPED_DIR
}

delite() {
    local DISALLOWED="$HOME/Test:$HOME/tmp"
    local CURRENT_DIR=$(pwd)

    local IFS=':'
    local -a ALLOWED_SNAP
    local -a DISALLOWED_ARR
    read -r -a ALLOWED_SNAP <<< "$SNAPSHOTABLE_PATH"
    read -r -a DISALLOWED_ARR <<< "$DISALLOWED"

    # SNAPSHOTABLE_PATH?
    local IN_ALLOWED=0
    for dir in "${ALLOWED_SNAP[@]}"; do
        [[ "$dir" == "$CURRENT_DIR" ]] && IN_ALLOWED=1 && break
    done

    # DISALLOWED?
    local IN_DISALLOWED=0
    for dir in "${DISALLOWED_ARR[@]}"; do
        [[ "$dir" == "$CURRENT_DIR" ]] && IN_DISALLOWED=1 && break
    done

    if [[ $IN_ALLOWED -eq 0 ]]; then
        echo "Nie można usunąć katalogu"
        return 1
    fi

    if [[ $IN_DISALLOWED -eq 1 ]]; then
        echo "Nie można usunąć katalogu"
        return 1
    fi

    cd ..
    sudo umount $CURRENT_DIR
    rm -r $CURRENT_DIR
    SNAPSHOTABLE_PATH=$(echo "$SNAPSHOTABLE_PATH" | tr ':' '\n' | grep -vxF "$CURRENT_DIR" | tr '\n' ':' | sed 's/:$//')
}
