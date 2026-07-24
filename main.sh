#!/usr/bin/env bash

RESET='\033[0m'
G='\033[0;32m'
B='\033[0;34m'




echo -e "

     █████╗ ██████╗  ██████╗ ███████╗███╗   ██╗████████╗ ██████╗ ███████╗
    ██╔══██╗██╔══██╗██╔════╝ ██╔════╝████╗  ██║╚══██╔══╝██╔═══██╗██╔════╝
    ███████║██████╔╝██║  ███╗█████╗  ██╔██╗ ██║   ██║   ██║   ██║███████╗
    ██╔══██║██╔══██╗██║   ██║██╔══╝  ██║╚██╗██║   ██║   ██║   ██║╚════██║
    ██║  ██║██║  ██║╚██████╔╝███████╗██║ ╚████║   ██║   ╚██████╔╝███████║
    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚══════╝

    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝

    --------------------- Script hecho por sloviso03 ---------------------

    Este proyecto es openSource, cualquier persona puede contribuir, hacer
    sus propias modificaciones y distribuirlo como desee.

";


echo -e "    Presiona cualquier tecla para continuar.";
read -r -p "    Presiona 'n' para cancelar: " doit

case "${doit}" in
    [Nn]) exit
    ;; *)
esac



echo -e "${G}Instalando todas las dependencias...${RESET}";
bash packages.sh
bash ./noctalia/noctalia.sh

echo -e "${G}Instalando las configuraciones...${RESET}";
bash folders.sh

echo -e "${G}Instalando el cursor...${RESET}";
bash cursor.sh

echo -e "${G}Instalación base completada.${RESET}"

mise doctor

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
if [ -n "$SSID" ]; then
    PSK=$(sudo awk '/wpa-psk/ {print $2}' /etc/network/interfaces | tr -d '# ')
    echo -e "${B}Migrando conexión Wi-Fi ($SSID) a NetworkManager...${RESET}"
    sudo nmcli device wifi connect "$SSID" password "$PSK" > /dev/null 2>&1 &
fi


echo -e "${G}Instalando y configurando Greetd + Tuigreet...${RESET}"
sudo apt install -y greetd tuigreet
sudo rm -f /etc/systemd/system/getty@tty1.service.d/override.conf
sudo mkdir -p /etc/greetd
sudo bash -c 'cat << EOF > /etc/greetd/config.toml
[default_session]
command = "tuigreet --time --asterisks --sessions /usr/share/wayland-sessions:/usr/share/xsessions"
user = "greeter"
EOF'

sudo systemctl enable greetd.service

sudo mkdir -p /usr/share/wayland-sessions
sudo bash -c 'cat << EOF > /usr/share/wayland-sessions/sway.desktop
[Desktop Entry]
Name=Sway
Comment=An i3-compatible Wayland compositor
Exec=sway
Type=Application
EOF'



read -r -p "¿Te gustaría reiniciar (recomendado)? (Y/N) " doit

case "${doit}" in
    [Yy]) sudo reboot now
    ;; *)
    echo -e "${G}Saliendo del script.${RESET}" ;;
esac
