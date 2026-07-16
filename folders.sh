#!/usr/bin/env bash

export SYSTEM_TIMEZONE=$(timedatectl show | grep Timezone | cut -d'=' -f2)

mkdir -p ~/.config/sway
cp sway/* ~/.config/sway

mkdir -p ~/.config/alacritty
cp alacritty/* ~/.config/alacritty

cp -f bash/.bashrc "$HOME/.bashrc"
source "$HOME/.bashrc"

sudo update-alternatives --set editor /usr/bin/micro

mkdir -p ~/.config/micro
cp -r micro/* ~/.config/micro/


mkdir -p /usr/share/backgrounds/argentOs
cp -r wallpapers/* /usr/share/backgrounds/argentOs
sudo chmod -R 755 /usr/share/backgrounds/argentOs


# Pasamos config de noctalia
# cp ~/.local/state/noctalia/settings.toml ~/argentOs-script/noctalia/settings.toml
source noctalia/noctalia.sh
mkdir -p ~/.local/state/noctalia
cp noctalia/settings.toml ~/.local/state/noctalia/settings.toml





