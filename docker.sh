#!/usr/bin/env bash

set -e

echo "--> Actualizando el sistema..."
sudo apt update

echo "--> Instalando dependencias necesarias y herramientas de virtualización (KVM/QEMU)..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    qemu-kvm \
    libvirt-daemon-system \
    libvirt-clients \
    bridge-utils \
    gnome-terminal

echo "--> Asegurando que los módulos de KVM estén activos..."
sudo modprobe kvm
if grep -q Intel /proc/cpuinfo; then
    sudo modprobe kvm_intel
elif grep -q AMD /proc/cpuinfo; then
    sudo modprobe kvm_amd
fi

echo "--> Configurando el repositorio oficial de Docker para Debian (Trixie)..."
sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/debian/gpg \
-o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: trixie
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

echo "--> Instalando Docker Engine y complementos..."
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "--> Descargando el paquete oficial de Docker Desktop para Debian..."
DOCKER_DESKTOP_URL="https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb"
curl -R -o /tmp/docker-desktop.deb "$DOCKER_DESKTOP_URL"

echo "--> Instalando Docker Desktop..."
sudo apt install -y /tmp/docker-desktop.deb
rm /tmp/docker-desktop.deb

echo "--> Configurando grupos y permisos para el usuario ($USER)..."
sudo usermod -aG docker "$USER"
sudo usermod -aG kvm "$USER"
sudo usermod -aG libvirt "$USER"

echo "--> Habilitando servicios del sistema..."
sudo systemctl enable --now docker
sudo systemctl enable --now libvirtd

echo "--> Configurando Docker Desktop para que inicie automáticamente por usuario..."
systemctl --user enable docker-desktop

echo "========================================================"
echo "¡Instalación de Docker Desktop finalizada con éxito!"
echo "IMPORTANTE: Cierra sesión y vuelve a iniciarla para que"
echo "los cambios de grupos (docker, kvm, libvirt) surtan efecto."
echo "========================================================"
