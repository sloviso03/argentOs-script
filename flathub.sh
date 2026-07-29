#!/usr/bin/env bash

set -e

echo "Instalando Flatpak..."
sudo apt install -y flatpak

echo "Agregando Flathub..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Creando acceso directo App Store..."

mkdir -p ~/.local/share/applications

cat > ~/.local/share/applications/app-store.desktop <<EOF
[Desktop Entry]
Name=App Store
Comment=Explorar aplicaciones de Flathub
Exec=xdg-open https://flathub.org
Terminal=false
Type=Application
Categories=Utility;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/app-store.desktop

echo "Listo. Reiniciá tu launcher de aplicaciones o la sesión de Sway."
