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
