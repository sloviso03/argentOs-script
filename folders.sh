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
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/bin:$PATH"
hash -r
source "$HOME/.bashrc"

sudo update-alternatives --set editor /usr/bin/micro
mkdir -p ~/.config/micro
cp -r micro/* ~/.config/micro/

sudo mkdir -p /usr/share/backgrounds/argentOs
sudo cp -r wallpapers/* /usr/share/backgrounds/argentOs
sudo chmod -R 755 /usr/share/backgrounds/argentOs


# noctalia
mkdir -p ~/.local/state/noctalia
pkill -f noctalia 2>/dev/null
cp noctalia/settings.toml ~/.local/state/noctalia/settings.toml

if pgrep -x sway > /dev/null; then
    noctalia --reload 2>/dev/null &
fi


mkdir -p ~/.config/Code/User
cp -r vscode/* ~/.config/Code/User/
