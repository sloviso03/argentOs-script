#!/usr/bin/env bash

set -e

REAL_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$REAL_USER")
USER_ID=$(id -u "$REAL_USER")

sudo apt update

sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    qemu-kvm \
    libvirt-daemon-system \
    libvirt-clients \
    bridge-utils \
    gnome-terminal

sudo modprobe kvm
if grep -q Intel /proc/cpuinfo; then
    sudo modprobe kvm_intel
elif grep -q AMD /proc/cpuinfo; then
    sudo modprobe kvm_amd
fi

sudo install -d -m 0755 /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg \
| sudo tee /etc/apt/keyrings/docker.asc >/dev/null

sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: trixie
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

curl -L \
    https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb \
    -o /tmp/docker-desktop.deb

sudo apt install -y /tmp/docker-desktop.deb
rm -f /tmp/docker-desktop.deb

sudo usermod -aG docker "$REAL_USER"
sudo usermod -aG kvm "$REAL_USER"
sudo usermod -aG libvirt "$REAL_USER"

sudo systemctl enable docker.service
sudo systemctl enable libvirtd.service

sudo systemctl start docker.service
sudo systemctl start libvirtd.service

sudo loginctl enable-linger "$REAL_USER"

sudo -u "$REAL_USER" mkdir -p "$USER_HOME/.config/autostart"
sudo -u "$REAL_USER" cp /usr/share/applications/docker-desktop.desktop "$USER_HOME/.config/autostart/"

sudo -u "$REAL_USER" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus" systemctl --user daemon-reload
sudo -u "$REAL_USER" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus" systemctl --user enable --now docker-desktop.service

echo
echo "========================================================"
echo "Docker y Docker Desktop se configuraron correctamente."
echo
echo "IMPORTANTE:"
echo "Cerrá sesión o reiniciá para que los permisos de grupo surtan efecto."
echo "========================================================"
