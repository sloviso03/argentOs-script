#!/usr/bin/env bash

set -e

echo "Instalando Flatpak..."
sudo apt install -y flatpak

echo "Agregando Flathub..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo


echo "Listo. Reiniciá la sesión de Sway."
