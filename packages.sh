#!/usr/bin/env bash

sudo apt update

sudo apt install -y \
  git unzip sway autotiling fonts-jetbrains-mono fzf micro fastfetch \
  network-manager network-manager-gnome bluez bluez-tools blueman \
  power-profiles-daemon upower vlc btop \
  pipewire-audio wireplumber pipewire-pulse pavucontrol \
  grim slurp wl-clipboard brightnessctl dolphin kanshi wdisplays \
  xdg-desktop-portal-wlr polkit-kde-agent-1 okular \
  libwebp7 librsvg2-common gsettings-desktop-schemas \
  wpasupplicant firmware-linux firmware-linux-nonfree \
  curl gir1.2-nm-1.0 gir1.2-nma-1.0 qt5ct qt6ct kde-style-breeze breeze-icon-theme \
  cups cups-client cups-bsd gtklp firefox-esr zoxide lame


sudo usermod -aG netdev $USER
sudo systemctl enable --now NetworkManager


curl https://mise.run/bash | sh
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/bin:$PATH"
if command -v mise &> /dev/null; then
    eval "$(mise activate bash)"
fi


source vscode.sh



sudo wget -q -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/dbeaver.gpg.key
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt-get update && sudo apt-get install dbeaver-ce



sudo apt purge -y gnome-keyring seahorse
sudo apt autoremove -y

for file in /etc/pam.d/login /etc/pam.d/passwd /etc/pam.d/gdm-password /etc/pam.d/lightdm; do
    if [ -f "$file" ]; then
        sudo sed -i '/pam_gnome_keyring\.so/s/^/#/' "$file"
    fi
done


curl -sS https://starship.rs/install.sh | sh
