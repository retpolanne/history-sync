#!/usr/bin/env sh

uname -s | grep "Darwin" || { echo "We still don't support Linux yet :( feel free to contribute!"; exit 1; }
test "$GPG_MAIL" || { echo "Please set the GPG_MAIL variable with your GPG email"; exit 1; }
gpg --list-keys | grep "$GPG_MAIL" || { echo "Please setup GPG with your email"; exit 1; }
test "$BACKUP_DIR" || { echo "Please set the backup path with the BACKUP_DIR variable"; exit 1; }

brew bundle
cat <<EOF> $HOME/Library/LaunchAgents/com.retpolanne.historysync.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>

    <key>Label</key>
    <string>com.retpolanne.historysync.plist</string>

    <key>RunAtLoad</key>
    <true/>

    <key>StartInterval</key>
    <integer>20</integer>

    <key>StandardOutPath</key>
    <string>/tmp/history-sync.out.log</string>

    <key>StandardErrorPath</key>
    <string>/tmp/history-sync.err.log</string>

    <key>EnvironmentVariables</key>
    <dict>
      <key>PATH</key>
      <string><![CDATA[/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$(brew --prefix fswatch)/bin:$(brew --prefix gpg)/bin]]></string>
      <key>GPG_MAIL</key>
      <string><![CDATA[$GPG_MAIL]]></string>
      <key>BACKUP_DIR</key>
      <string><![CDATA[$BACKUP_DIR]]></string>
    </dict>

    <key>WorkingDirectory</key>
    <string>/Users/annemacedo/Dev/history-sync</string>

    <key>ProgramArguments</key>
    <array>
      <string>$SHELL</string>
      <string>-c</string>
      <string>$PWD/history-sync.sh</string>
    </array>

    <key>UserName</key>
    <string>$(whoami)</string>

  </dict>
</plist>
EOF
plutil $HOME/Library/LaunchAgents/com.retpolanne.historysync.plist
launchctl load $HOME/Library/LaunchAgents/com.retpolanne.historysync.plist 2>/dev/null
launchctl unload $HOME/Library/LaunchAgents/com.retpolanne.historysync.plist
launchctl load $HOME/Library/LaunchAgents/com.retpolanne.historysync.plist
