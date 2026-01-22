#!/usr/bin/env bash

PACKAGE_FILE="${1:-packages.txt}"

if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Package file $PACKAGE_FILE not found"
    exit 1
fi

echo "Installing packages from $PACKAGE_FILE..."

grep -vE '^#|^$' "$PACKAGE_FILE" | awk '{print $1}' | xargs sudo pacman -Syu --noconfirm

echo "Done installing packages"
