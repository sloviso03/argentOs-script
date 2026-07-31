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

echo "--> Cargando módulos KVM..."
sudo modprobe kvm
if grep -q Intel /proc/cpuinfo; then
    sudo modprobe kvm_intel
elif grep -q AMD /proc/cpuinfo; then
    sudo modprobe kvm_amd
fi

echo "--> Configurando repositorio oficial de Docker..."
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

echo "--> Instalando Docker Engine..."
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "--> Descargando Docker Desktop..."
curl -L \
    https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb \
    -o /tmp/docker-desktop.deb

echo "--> Instalando Docker Desktop..."
sudo apt install -y /tmp/docker-desktop.deb
rm -f /tmp/docker-desktop.deb

echo "--> Agregando usuario a los grupos..."
sudo usermod -aG docker "$USER"
sudo usermod -aG kvm "$USER"
sudo usermod -aG libvirt "$USER"

echo "--> Habilitando servicios del sistema..."
sudo systemctl enable docker.service
sudo systemctl enable libvirtd.service

sudo systemctl start docker.service
sudo systemctl start libvirtd.service

echo "--> Creando servicio temporal para activar Docker Desktop tras el primer reinicio..."

mkdir -p ~/.config/systemd/user

cat > ~/.config/systemd/user/docker-desktop-first-login.service <<'EOF'
[Unit]
Description=Enable Docker Desktop on first login
After=default.target

[Service]
Type=oneshot
ExecStart=/bin/sh -c '\
systemctl --user enable docker-desktop.service && \
systemctl --user start docker-desktop.service && \
systemctl --user disable docker-desktop-first-login.service && \
rm -f ~/.config/systemd/user/docker-desktop-first-login.service && \
systemctl --user daemon-reload'

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable docker-desktop-first-login.service

echo
echo "========================================================"
echo "Docker se instaló correctamente."
echo
echo "Al reiniciar:"
echo "  ✓ docker.service arrancará automáticamente."
echo "  ✓ libvirtd.service arrancará automáticamente."
echo "  ✓ Docker Desktop se habilitará automáticamente"
echo "    en el primer inicio de sesión y luego eliminará"
echo "    el servicio temporal."
echo "========================================================"
