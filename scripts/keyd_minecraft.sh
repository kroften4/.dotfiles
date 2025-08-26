#!/usr/bin/env bash

cp $HOME/.config/keyd_profiles/minecraft.conf /etc/keyd/default.conf
sudo /bin/systemctl restart keyd.service

