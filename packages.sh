#!/usr/bin/env bash

sudo apt update

sudo apt install -y \
  git unzip sway autotiling fonts-jetbrains-mono fzf micro fastfetch \
  network-manager network-manager-gnome bluez bluez-tools blueman \
  power-profiles-daemon upower vlc \
  pipewire-audio wireplumber pipewire-pulse pavucontrol \
  grim slurp wl-clipboard brightnessctl dolphin kanshi wdisplays \
  xdg-desktop-portal-wlr polkit-kde-agent-1 okular \
  libwebp7 librsvg2-common gsettings-desktop-schemas \
  wpasupplicant firmware-linux firmware-linux-nonfree \
  curl gir1.2-nm-1.0 gir1.2-nma-1.0 qt5ct qt6ct kde-style-breeze \
  cups cups-client cups-bsd gtklp firefox-esr qutebrowser


sudo usermod -aG netdev $USER
sudo systemctl enable --now NetworkManager


curl https://mise.run/bash | sh
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/bin:$PATH"
if command -v mise &> /dev/null; then
    eval "$(mise activate bash)"
fi


source vscode.sh
