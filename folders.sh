#!/usr/bin/env bash
export SYSTEM_TIMEZONE=$(timedatectl show | grep Timezone | cut -d'=' -f2)

mkdir -p ~/.config/niri
cp niri/config.kdl ~/.config/niri/config.kdl

cp wallpaper.png ~/.config/niri/wallpaper.png
sed -i "s|\${WALLPAPER_PATH}|$HOME/.config/niri/wallpaper.png|g" ~/.config/niri/config.kdl

mkdir -p ~/.config/alacritty
cp alacritty/* ~/.config/alacritty

mkdir -p ~/.config/waybar
cp waybar/config.jsonc ~/.config/waybar/config.jsonc
cp waybar/power_menu.sh ~/.config/waybar/
chmod +x ~/.config/waybar/power_menu.sh
sed -i "s|\${SYSTEM_TIMEZONE}|$SYSTEM_TIMEZONE|g" ~/.config/waybar/config.jsonc
cp waybar/style.css ~/.config/waybar/style.css

mkdir -p ~/.config/fastfetch
cp fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc

cp -f bash/.bashrc "$HOME/.bashrc"

mkdir -p ~/.config/micro
mkdir -p ~/.config/micro/colorschemes
cp -r micro/* ~/.config/micro/

mkdir -p ~/.config/fuzzel
cp -r fuzzel/* ~/.config/fuzzel/

mkdir -p ~/.config/kanshi
cp kanshi/config ~/.config/kanshi/config

mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml
cat > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xsettings" version="1.0">
<property name="Net" type="empty">
<property name="ThemeName" type="string" value="Adwaita-dark"/>
</property>
</channel>
EOF

mkdir -p ~/.config/xdg-desktop-portal
cat > ~/.config/xdg-desktop-portal/niri-portals.conf << 'EOF'
[preferred]
default=gnome
org.freedesktop.impl.portal.ScreenCast=gnome
org.freedesktop.impl.portal.Screenshot=gnome
org.freedesktop.impl.portal.FileChooser=gtk
EOF

xdg-mime default thunar.desktop inode/directory
systemctl --user daemon-reload
systemctl --user enable --now pipewire pipewire-pulse wireplumber