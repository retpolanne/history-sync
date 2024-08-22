#!/usr/bin/env sh

test "$GPG_MAIL" || { echo "Please set the GPG_MAIL variable with your GPG email"; exit 1; }
test "$BACKUP_DIR" || { echo "Please set the backup path with the BACKUP_DIR variable"; exit 1; }

case $SHELL in
     "/bin/zsh")
         history_file=".zsh_history"
         ;;
     "/bin/bash")
         history_file=".bash_history"
         ;;
esac

history_fullpath="$HOME/$history_file"

echo "Reading $history_fullpath and encrypting for $GPG_MAIL - backup location $BACKUP_DIR/$history_file.gpg"
fswatch -o "$history_fullpath" | while read event
do
    echo "Encrypting $history_fullpath"
    gpg --yes -r "$GPG_MAIL" --output "$BACKUP_DIR/$history_file.gpg" -e "$history_fullpath" && \
        echo "Encrypted at $(date)" || \
        echo "Failed to encrypt file!"
done
