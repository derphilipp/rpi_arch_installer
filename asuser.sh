#!/usr/bin/env bash
set -Eeuo pipefail

if [ -f "/usr/bin/yay" ]; then
    echo "Nice, yay is installed"
else
    cd /tmp
    sudo rm -rf /tmp/yay || true
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd /tmp
    sudo rm -rf /tmp/yay
fi

SSH_FILE=~/.ssh/id_ed25519

if [ -f "$SSH_FILE" ]; then
    echo "SSH-Key already exists"
else
    ssh-keygen -o -a 100 -t ed25519 -f $SSH_FILE
fi

sudo sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

yay -S vcsh myrepos tldr topgrade

chsh -s /usr/bin/fish


cat ~/.ssh/id_ed25519.pub

read

vcsh clone git@github.com:derphilipp/_mr mr
mr co
