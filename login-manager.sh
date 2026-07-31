#!/usr/bin/env bash
set -e

echo "Instalando SDDM..."

sudo apt update
sudo apt install -y sddm

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
echo " - KDE"
echo " - XFCE"
echo " - GNOME"
echo " - cualquier otro instalado"
echo "===================================="
