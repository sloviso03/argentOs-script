#!/usr/bin/env bash
set -e

echo "Instalando SDDM..."

sudo apt update

sudo apt install --no-install-recommends -y \
    sddm \
    plasma-discover \
    partitionmanager


echo "Creando sesión de Sway..."

sudo mkdir -p /usr/share/wayland-sessions

sudo tee /usr/share/wayland-sessions/sway.desktop >/dev/null <<EOF
[Desktop Entry]
Name=Sway
Comment=Sway Wayland Compositor
Exec=sway
Type=Application
DesktopNames=sway
EOF

echo "Habilitando SDDM..."

sudo systemctl disable gdm 2>/dev/null || true
sudo systemctl disable lightdm 2>/dev/null || true
sudo systemctl disable lxdm 2>/dev/null || true

sudo systemctl enable sddm

echo
echo "===================================="
echo "SDDM instalado correctamente."
echo
echo "En el próximo reinicio aparecerá:"
echo
echo " - Usuario"
echo " - Contraseña"
echo " - Selector de escritorio"
echo
echo "Podrás elegir:"
echo " - Sway"
echo " - cualquier otro instalado"
echo "===================================="



echo "Instalando tema Qylock para SDDM..."

sudo apt install --no-install-recommends -y \
    git \
    qt6-declarative-dev \
    qt6-5compat-dev \
    libqt6svg6 \
    qml6-module-qtmultimedia \
    qml6-module-qtquick-controls \
    qml6-module-qtquick-layouts

sudo rm -rf /tmp/qylock

git clone https://github.com/Darkkal44/qylock.git /tmp/qylock

sudo mkdir -p /usr/share/sddm/themes

sudo cp -r /tmp/qylock/themes/* /usr/share/sddm/themes/

sudo mkdir -p /etc/sddm.conf.d

sudo tee /etc/sddm.conf.d/theme.conf >/dev/null <<EOF
[Theme]
Current=minecraft
EOF

echo "Tema Qylock instalado."

