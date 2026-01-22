#!/usr/bin/env bash

SCRIPT_PATH="power-profile-auto.sh"
RULES_PATH="99-power-profile.rules"
SERVICE_PATH="power-profile-auto.service"

sudo cp $SCRIPT_PATH /usr/local/bin/
sudo chmod +x /usr/local/bin/power-profile-auto.sh

sudo cp $RULES_PATH /etc/udev/rules.d/99-power-profile.rules
sudo udevadm control --reload-rules
sudo udevadm trigger

sudo cp $SERVICE_PATH /etc/systemd/system/power-profile-auto.service
sudo systemctl enable power-profile-auto.service
