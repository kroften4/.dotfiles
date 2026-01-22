#!/usr/bin/env bash

bash ./install_packages.sh

# TODO: scripts use relative dirs which might not work
bash ./nvim.sh
bash ./power-profile-auto/install.sh
