#!/usr/bin/env bash

sudo cp $HOME/.config/keyd_profiles/default.conf /etc/keyd/default.conf
sudo systemctl restart keyd

