#!/usr/bin/env bash
RESET='\033[0m'
G='\033[0;32m'
B='\033[0;34m'


cat << 'EOF'

                                     .d88b. 88888b. 888  888
                                    d88P"88b888 "88b888  888
                                    888  888888  888888  888
                                    Y88b 888888  888Y88b 888
                                     "Y88888888  888 "Y88888
       (    )                            888 and debian? lol
        ~oo~                        Y8b d88P   sloviso03
         .. Gnu!                     "Y88P"
         / =\   \=
        -   -    -      =-=-The choice of the Linux generation-=-=

       This software is open-source: you can redistribute it and/or
       modify it under the terms of the GNU General Public License
       as published by the Free Software Foundation.

       This is distributed in the hope that it will be useful, but
       WITHOUT ANY WARRANTY; without even the implied warranty of
       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

       ASCII ART FROM: https://ascii.co.uk/art/gnu

EOF


echo -e "    Presiona cualquier tecla para continuar.";
read -r -p "    Presiona 'n' para cancelar: " doit

case "${doit}" in
    [Nn]) exit
    ;; *)
esac


echo -e "${G}Instalando todas las dependencias...${RESET}";
bash packages.sh
bash swayfx.sh
bash ./noctalia/noctalia.sh

echo -e "${G}Instalando las configuraciones...${RESET}";
bash folders.sh

echo -e "${G}Instalando el cursor...${RESET}";
bash cursor.sh

echo -e "${G}Instalación base completada.${RESET}"


read -r -p "¿Te gustaría pasar al menú de lenguajes de programación? (Y/N) " doit

case "${doit}" in
    [Yy]) bash options.sh
    ;; *)
    echo -e "${G}Saliendo sin abrir el menú de lenguajes.${RESET}" ;;
esac

read -r -p "¿Te gustaría instalar docker? (Y/N) " doit

case "${doit}" in
    [Yy]) bash docker.sh
    ;; *)
    echo -e "${G}Saliendo sin instalar Docker.${RESET}" ;;
esac








bash hide.sh



read -r -p "¿Instalar SDDM como Login Manager? (Y/N) " doit

case "$doit" in
    [Yy])
        bash login-manager.sh
        ;;
    *)
        echo "Saltando instalación de SDDM."
        ;;
esac









echo -e "${G}Optimizando la gestión de red con NetworkManager...${RESET}"

SSID=""
PSK=""

if [ -f /etc/wpa_supplicant/wpa_supplicant.conf ]; then
    SSID=$(sudo grep -m1 'ssid=' /etc/wpa_supplicant/wpa_supplicant.conf | sed 's/.*ssid=//' | tr -d '"')
    PSK=$(sudo grep -m1 'psk=' /etc/wpa_supplicant/wpa_supplicant.conf | sed 's/.*psk=//' | tr -d '"')
fi

if [ -z "$SSID" ] && [ -f /etc/network/interfaces ]; then
    SSID=$(sudo awk '/wpa-ssid/ {print $2}' /etc/network/interfaces)
    PSK=$(sudo awk '/wpa-psk/ {print $2}' /etc/network/interfaces)
fi

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

if [ -n "$SSID" ] && [ -n "$PSK" ]; then
    echo -e "${B}Migrando conexión Wi-Fi ($SSID) a NetworkManager...${RESET}"
    sudo nmcli connection delete "$SSID" 2>/dev/null
    sudo nmcli device wifi connect "$SSID" password "$PSK"
fi




read -r -p "¿Te gustaría reiniciar (recomendado)? (Y/N) " doit

case "${doit}" in
    [Yy]) sudo reboot now
    ;; *)
    echo -e "${G}Saliendo del script.${RESET}" ;;
esac
