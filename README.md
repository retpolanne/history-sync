# history-sync

Sync your bash/zsh history safely.

This is a bash script that uses GPG and fswatch to encrypt your terminal's history file and moves it to a backup dir, that you can easily backup with iCloud Drive, Google Drive, Dropbox or whatever you use for backups. 

## Installation

Assuming you're on a Mac with Homebrew installed, clone this repo and run: 

``` sh
brew bundle
```

Follow [this guide](https://www.gnupg.org/gph/en/manual/c14.html) to setup GPG. 


## Recommended usage

If on a Mac, run `install.sh` for this program to be installed as a LaunchAgent.

## Syncing back

**Before installing this tool on a new computer**, recover your history backup first, otherwise it can be overwritten.

``` sh
# If using zsh
cp $BACKUP_DIR/.zsh_history.gpg /tmp
gpg -r $GPG_MAIL --output $HOME/.zsh_history -d /tmp/.zsh_history.gpg
```

Then install this tool to keep your history synced :)
