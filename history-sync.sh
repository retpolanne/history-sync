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

echo "Reading $history_file and encrypting for $GPG_MAIL"
fswatch -o $history_file | xargs gpg -r "$GPG_MAIL" --output "$BACKUP_DIR/"
