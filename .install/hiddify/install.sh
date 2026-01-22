#!/usr/bin/env bash

$USER_SAVE = $USER

sudo rm -rf /usr/share/applications/hiddify.desktop
cp ./Hiddify.desktop $HOME/.local/share/applications/

sudo touch /etc/sudoers.d/00_$USER_SAVE
sudo chmod +w /etc/sudoers.d/00_$USER_SAVE
sudo bash -c 'echo "$USER_SAVE ALL = NOPASSWD:SETENV: /usr/bin/hiddify" >> /etc/sudoers.d/00_$USER_SAVE'
sudo chmod -w /etc/sudoers.d/00_$USER_SAVE
