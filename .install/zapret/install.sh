#!/usr/bin/env bash

$USER_SAVE = $USER

git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux /opt/zapret/
mkdir $HOME/.config/zapret
ln -s /opt/zapret/conf.env $HOME/.config/zapret/
cp ./Zapret.desktop $HOME/.local/share/applications/

sudo touch /etc/sudoers.d/00_$USER_SAVE
sudo chmod +w /etc/sudoers.d/00_$USER_SAVE
sudo bash -c 'echo "$USER_SAVE ALL = NOPASSWD: /opt/zapret/main_script.sh" >> /etc/sudoers.d/00_$USER_SAVE'
sudo chmod -w /etc/sudoers.d/00_$USER_SAVE
