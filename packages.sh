#!/usr/bin/env bash

sudo apt update

sudo apt install -y \
  git qutebrowser unzip sway autotiling fonts-jetbrains-mono fzf micro fastfetch \
  network-manager network-manager-gnome bluez bluez-tools blueman \
  power-profiles-daemon upower audacious \
  pipewire-audio wireplumber pipewire-pulse pavucontrol \
  grim slurp wl-clipboard brightnessctl dolphin \
  xdg-desktop-portal-wlr polkit-kde-agent-1 okular \
  libwebp7 librsvg2-common gsettings-desktop-schemas \
  wpasupplicant firmware-linux firmware-linux-nonfree \
  curl gir1.2-nm-1.0 gir1.2-nma-1.0 qt5ct qt6ct kde-style-breeze \
  cups cups-client cups-bsd gtklp


sudo usermod -aG netdev $USER
sudo systemctl enable --now NetworkManager


sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf && sudo extrepo update librewolf
sudo apt update && sudo apt install librewolf -y


curl https://mise.run/bash | sh

curl -f https://zed.dev/install.sh | sh
