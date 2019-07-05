#!/usr/bin/env bash
set -Eeuo pipefail

pacman-key --init
pacman-key --populate archlinuxarm

useradd phw
mkdir /home/phw
sudo chown phw /home/phw
pacman -S git sudo binutils tmux make gcc fakeroot python-neovim neovim fish fzf fd bat exa thefuck
usermod -aG sudo username
visudo
