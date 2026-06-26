#!/usr/bin/env bash

RESET='\033[0m'
G='\033[0;32m'
B='\033[0;34m'


echo -e "${B}ArgentOs-script${RESET}";

echo -e "${G}Instalando todas las dependencias...${RESET}";
source packages.sh

echo -e "${G}Generando config de sway...${RESET}";
mkdir -p ~/.config/sway
cp sway/* ~/.config/sway
echo -e "${G}Sway config moved to main${RESET}";

echo -e "${G}Generando config de alacritty...${RESET}";
mkdir -p ~/.config/alacritty
cp alacritty/* ~/.config/alacritty
echo -e "${G}Alacritty config moved to main${RESET}";

echo -e "${G}Generando config de waybar...${RESET}";
mkdir -p ~/.config/waybar
cp waybar/* ~/.config/waybar
echo -e "${G}Waybar config moved to main${RESET}";
