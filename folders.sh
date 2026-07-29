#!/usr/bin/env bash

export SYSTEM_TIMEZONE=$(timedatectl show | grep Timezone | cut -d'=' -f2)

mkdir -p ~/.config/sway
cp sway/* ~/.config/sway

mkdir -p ~/.config/foot
cp foot/* ~/.config/foot


cp starship/* ~/.config


cp -f bash/.bashrc "$HOME/.bashrc"
cp -f bash/.bash_profile "$HOME/.bash_profile"
hash -r

sudo update-alternatives --set editor /usr/bin/micro
mkdir -p ~/.config/micro
bash micro.sh
cp -r micro/* ~/.config/micro/

sudo mkdir -p /usr/share/backgrounds/argentOs
sudo cp -r wallpapers/* /usr/share/backgrounds/argentOs
sudo chmod -R 755 /usr/share/backgrounds/argentOs


# noctalia
killall noctalia 2>/dev/null
mkdir -p ~/.local/state/noctalia
cp noctalia/settings.toml ~/.local/state/noctalia/settings.toml

if pgrep -x "sway" > /dev/null; then
    noctalia &>/dev/null &
fi


mkdir -p ~/.config/Code/User
cp -r vscode/* ~/.config/Code/User/
