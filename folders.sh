#!/usr/bin/env bash

export SYSTEM_TIMEZONE=$(timedatectl show | grep Timezone | cut -d'=' -f2)

mkdir -p ~/.config/sway
cp sway/* ~/.config/sway

mkdir -p ~/.config/foot
cp foot/* ~/.config/foot

mkdir -p ~/.config/fastfetch
cp fastfetch/* ~/.config/fastfetch

cp -f bash/.bashrc "$HOME/.bashrc"
cp -f bash/.bash_profile "$HOME/.bash_profile"
source "$HOME/.bashrc"

sudo update-alternatives --set editor /usr/bin/micro
mkdir -p ~/.config/micro
cp -r micro/* ~/.config/micro/

sudo mkdir -p /usr/share/backgrounds/argentOs
sudo cp -r wallpapers/* /usr/share/backgrounds/argentOs
sudo chmod -R 755 /usr/share/backgrounds/argentOs


# Pasamos config de noctalia
# cp ~/.local/state/noctalia/settings.toml ~/argentOs-script/noctalia/settings.toml
mkdir -p ~/.local/state/noctalia
cp noctalia/settings.toml ~/.local/state/noctalia/settings.toml



sudo mkdir -p ~/.config/Code/User
sudo cp -r vscode/* ~/.config/Code/User/
