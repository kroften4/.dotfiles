#!/usr/bin/env bash

sudo pacman -S bob
bob use nightly

# TODO: isntall mason lsps

# this plugin does not work without this for some reason
pushd $HOME/.local/share/nvim/site/pack/core/opt/markdown-preview.nvim/
npm install
popd
