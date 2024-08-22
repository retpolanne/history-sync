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
