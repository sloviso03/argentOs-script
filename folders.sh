#!/usr/bin/env bash

export SYSTEM_TIMEZONE=$(timedatectl show | grep Timezone | cut -d'=' -f2)

mkdir -p ~/.config/sway
cp sway/* ~/.config/sway

mkdir -p ~/.config/foot
cp foot/* ~/.config/foot

mkdir -p ~/.config/fresh
cp -r fresh/* ~/.config/fresh



cp starship/* ~/.config


cp -f bash/.bashrc "$HOME/.bashrc"
cp -f bash/.bash_profile "$HOME/.bash_profile"
hash -r

sudo update-alternatives --set editor /usr/bin/micro
mkdir -p ~/.config/micro
bash micro.sh
cp -r micro/* ~/.config/micro/

mkdir -p "$HOME/Pictures/wallpapers"
sudo cp -r wallpapers/* "$HOME/Pictures/wallpapers"

# noctalia
killall noctalia 2>/dev/null
mkdir -p ~/.local/state/noctalia
cp noctalia/settings.toml ~/.local/state/noctalia/settings.toml

if pgrep -x "sway" > /dev/null; then
    noctalia &>/dev/null &
fi


mkdir -p ~/.config/Code/User
cp -r vscode/* ~/.config/Code/User/





# Dolphin setup
sudo mkdir -p /usr/share/kio/servicemenus

sudo tee /usr/share/kio/servicemenus/open-foot-here.desktop >/dev/null <<'EOF'
[Desktop Entry]
Type=Service
MimeType=inode/directory;
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
Actions=openFootHere;

[Desktop Action openFootHere]
Name=Open Foot Here
Icon=utilities-terminal
Exec=foot -D %f
EOF

kwriteconfig6 --file ~/.config/dolphinrc \
  --group ContextMenu \
  --key ShowOpenTerminal false
