#!/usr/bin/env bash

export SYSTEM_TIMEZONE=$(timedatectl show | grep Timezone | cut -d'=' -f2)

mkdir -p ~/.config/sway
cp sway/* ~/.config/sway

mkdir -p ~/.config/alacritty
cp alacritty/* ~/.config/alacritty

mkdir -p ~/.config/waybar
cp waybar/config.jsonc ~/.config/waybar/config.jsonc
cp waybar/power_menu.sh ~/.config/waybar/
chmod +x ~/.config/waybar/power_menu.sh
sed -i "s|\${SYSTEM_TIMEZONE}|$SYSTEM_TIMEZONE|g" ~/.config/waybar/config.jsonc
cp waybar/style.css ~/.config/waybar/style.css

mkdir -p ~/.config/fastfetch
cp fastfetch/* ~/.config/fastfetch/config.jsonc


cp -f bash/.bashrc "$HOME/.bashrc"
source "$HOME/.bashrc"

sudo update-alternatives --set editor /usr/bin/micro

mkdir -p ~/.config/micro
cp -r micro/* ~/.config/micro/


mkdir -p ~/.config/fuzzel
cp -r fuzzel/* ~/.config/fuzzel/



mkdir -p ~/.config/kanshi
cp kanshi/config ~/.config/kanshi/config


mkdir -p ~/.config/gtk-3.0
cp gtk/gtk-3.0.css ~/.config/gtk-3.0/gtk.css
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml
echo '<?xml version="1.0" encoding="UTF-8"?><channel name="xsettings" version="1.0"><property name="Net" type="empty"><property name="ThemeName" type="string" value="Adwaita-dark"/></property></channel>' > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
xdg-mime default thunar.desktop inode/directory


systemctl --user daemon-reload
systemctl --user enable --now pipewire pipewire-pulse wireplumber
