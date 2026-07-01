#!/usr/bin/env bash

export SYSTEM_TIMEZONE=$(timedatectl show | grep Timezone | cut -d'=' -f2)

mkdir -p ~/.config/sway
cp sway/* ~/.config/sway

mkdir -p ~/.config/alacritty
cp alacritty/* ~/.config/alacritty

mkdir -p ~/.config/waybar
cp waybar/config.jsonc ~/.config/waybar/config.jsonc
sed -i "s|\${SYSTEM_TIMEZONE}|$SYSTEM_TIMEZONE|g" ~/.config/waybar/config.jsonc
cp waybar/style.css ~/.config/waybar/style.css

mkdir -p ~/.config/fastfetch
cp fastfetch/* ~/.config/fastfetch/config.jsonc

xdg-mime default ranger.desktop inode/directory
mkdir -p ~/.local/share/applications
cp ranger/* ~/.local/share/applications/

cp -f bash/.bashrc "$HOME/.bashrc"
source "$HOME/.bashrc"

sudo update-alternatives --set editor /usr/bin/micro

mkdir -p ~/.config/micro
cp -r micro/* ~/.config/micro/


mkdir -p ~/.config/fuzzel
cp -r fuzzel/* ~/.config/fuzzel/



mkdir -p ~/.config/kanshi
cp kanshi/config ~/.config/kanshi/config



systemctl --user daemon-reload
systemctl --user enable --now pipewire pipewire-pulse wireplumber
