#!/usr/bin/env bash

RESET='\033[0m'
G='\033[0;32m'
B='\033[0;34m'


echo -e "${B}ArgentOs-script${RESET}";

echo -e "${G}Instalando todas las dependencias...${RESET}";
source packages.sh
source ./noctalia/noctalia.sh

echo -e "${G}Instalando las configuraciones...${RESET}";
source folders.sh

echo -e "${G}Instalando el cursor...${RESET}";
source cursor.sh

echo -e "${G}Instalación base completada.${RESET}"

mise doctor

read -r -p "¿Te gustaría pasar al menú de lenguajes de programación? (Y/N) " doit

case "${doit}" in
    [Yy]) source options.sh
    ;; *)
    echo -e "${G}Saliendo sin abrir el menú de lenguajes.${RESET}" ;;
esac



echo -e "${G}Optimizando la gestión de red con NetworkManager...${RESET}"

if [ -f /etc/network/interfaces ]; then
    sudo sed -i '/wlp3s0/s/^/# /' /etc/network/interfaces
    sudo sed -i '/wpa-ssid/s/^/# /' /etc/network/interfaces
    sudo sed -i '/wpa-psk/s/^/# /' /etc/network/interfaces
fi

if [ -f /etc/NetworkManager/NetworkManager.conf ]; then
    sudo sed -i 's/managed=false/managed=true/g' /etc/NetworkManager/NetworkManager.conf
fi

echo -e "${B}Reiniciando servicios de red...${RESET}"
sudo systemctl restart networking
sudo systemctl restart NetworkManager

SSID=$(sudo awk '/wpa-ssid/ {print $2}' /etc/network/interfaces | tr -d '# ')
if [ -not -z "$SSID" ]; then
    PSK=$(sudo awk '/wpa-psk/ {print $2}' /etc/network/interfaces | tr -d '# ')
    echo -e "${B}Migrando conexión Wi-Fi ($SSID) a NetworkManager...${RESET}"
    sudo nmcli device wifi connect "$SSID" password "$PSK" > /dev/null 2>&1 &
fi
