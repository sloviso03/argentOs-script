#!/usr/bin/env bash

sudo apt update

sudo apt install -y \
  sway firefox-esr autotiling fonts-jetbrains-mono alacritty fzf micro fastfetch \
  network-manager bluez bluez-tools blueman \
  power-profiles-daemon upower \
  pipewire-audio wireplumber pipewire-pulse pavucontrol \
  grim slurp wl-clipboard brightnessctl dolphin \
  xdg-desktop-portal-wlr polkit-kde-agent-1 \
  libwebp7 librsvg2-common


sudo systemctl enable --now NetworkManager
