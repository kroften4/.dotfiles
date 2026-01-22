#!/usr/bin/env bash

DOTFILES_REPO="$HOME/.dotfiles"
TRACK_LIST="$HOME/.config/dotfiles/tracked.conf"

dotfiles() {
    git --git-dir="$DOTFILES_REPO" --work-tree="$HOME" "$@"
}

while IFS= read -r line; do
    # Remove everything after '#'
    path="${line%%#*}"
    # Remove whitespace
    path="$(echo -e "${path}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    
    # Skip empty lines
    if [[ -z "$path" ]]; then
        continue
    fi
    
    dotfiles add "$HOME/$path"
    
done < "$TRACK_LIST"

echo -e "\n"
dotfiles status --short
