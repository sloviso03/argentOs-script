#!/usr/bin/env bash
RESET='\033[0m'
G='\033[0;32m'
B='\033[0;34m'

echo -e "${B}ArgentOs-script${RESET}";

echo -e "${G}Instalando todas las dependencias...${RESET}";
source packages.sh

echo -e "${G}Instalando las configuraciones...${RESET}";
source folders.sh

echo -e "${G}Instalando el cursor...${RESET}";
source cursor.sh
