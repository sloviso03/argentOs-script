#!/usr/bin/env bash

export SYSTEM_TIMEZONE=$(timedatectl show | grep Timezone | cut -d'=' -f2)

mkdir -p ~/.config/sway
cp sway/* ~/.config/sway

mkdir -p ~/.config/alacritty
cp alacritty/* ~/.config/alacritty

mkdir -p ~/.config/waybar
envsubst < waybar/config.jsonc > ~/.config/waybar/config.jsonc
cp waybar/style.css ~/.config/waybar/style.css

mkdir -p ~/.config/fastfetch
cp fastfetch/* ~/.config/fastfetch/config.jsonc
