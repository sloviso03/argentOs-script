#!/usr/bin/env bash
RESET='\033[0m'
G='\033[0;32m'
B='\033[0;34m'


echo -e "
                                  _,met$$$$$gg.
                               ,g$$$$$$$$$$$$$$$P.
                             ,g$$P""       """Y$$.".
                            ,$$P'              `$$$.
                          ',$$P       ,ggs.     `$$b:
                          `d$$'     ,$P"'   .    $$$
                           $$P      d$'     ,    $$P
                           $$:      $$.   -    ,d$$'
                           $$;      Y$b._   _,d$P'
                           Y$$.    `.`"Y$$$$P"'
                           `$$b      "-.__
                            `Y$$b
                             `Y$$.
                               `$$b.
                                 `Y$$b.
                                   `"Y$b._
                                       `""""

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


read -r -p "¿Te gustaría reiniciar (recomendado)? (Y/N) " doit

case "${doit}" in
    [Yy]) sudo reboot now
    ;; *)
    echo -e "${G}Saliendo del script.${RESET}" ;;
esac
