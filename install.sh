#!/bin/bash

if [ $TERM == "screen-256color" -o $TERM == "screen" ]
then
    echo "Please run install.sh outside of a screen / tmux session."
    exit
fi

cp LaunchAgents/info.jaidev.togglewifi.plist ~/Library/LaunchAgents/
chmod 600 LaunchAgents/info.jaidev.togglewifi.plist

sudo cp Scripts/toggleWiFi.sh /Library/Scripts/
sudo chmod 755 /Library/Scripts/toggleWiFi.sh

launchctl load ~/Library/LaunchAgents/info.jaidev.togglewifi.plist
