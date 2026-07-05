#!/usr/bin/env bash

OPCIONES=("C#" "Go" "Java" "Node.js" "Rust")
ELEGIDOS=()

mostrarMenu() {
    clear
    echo "ArgentOs Developer Setup"
    echo "¿Qué te gustaría instalar che?"
    echo ""

    for i in "${!OPCIONES[@]}"; do
        local lenguaje="${OPCIONES[$i]}"
        local estado=" "

        if [[ " ${ELEGIDOS[*]} " =~ " ${lenguaje} " ]]; then
            estado="*"
        fi

        printf "%d. [%c] %s\n" "$((i+1))" "$estado" "$lenguaje"
    done

    printf "%d. Salir\n" "$(( ${#OPCIONES[@]} + 1 ))"
    echo ""

    if [ ${#ELEGIDOS[@]} -ne 0 ]; then
        echo "Seleccionados actualmente: ${ELEGIDOS[*]}"
        echo ""
    fi
}

ejecutarInstalacion() {
    clear
    if [ ${#ELEGIDOS[@]} -eq 0 ]; then
        echo "No seleccionaste nada. Saliendo..."
        exit 0
    fi

    echo "Iniciando instalación..."
    echo ""
    for lenguaje in "${ELEGIDOS[@]}"; do
        echo "Simulando instalación de: $lenguaje..."
        sleep 1
    done
    echo ""
    echo "¡Configuración completada con éxito!"
}

main() {
    local limite=${#OPCIONES[@]}
    local opcion_confirmar=$((limite + 1))

    while true; do
        mostrarMenu
        read -p "Elige una opción: " entrada

        if [ "$entrada" -eq "$opcion_confirmar" ] 2>/dev/null; then
            break
        fi

        if [[ "$entrada" -gt 0 && "$entrada" -le "$limite" ]] 2>/dev/null; then
            local seleccion=${OPCIONES[$((entrada-1))]}

            if [[ " ${ELEGIDOS[*]} " =~ " ${seleccion} " ]]; then
                local nuevos_elegidos=()
                for el in "${ELEGIDOS[@]}"; do
                    if [[ "$el" != "$seleccion" ]]; then
                        nuevos_elegidos+=("$el")
                    fi
                done
                ELEGIDOS=("${nuevos_elegidos[@]}")
            else
                ELEGIDOS+=("$seleccion")
            fi
        else
            echo "Opción no válida."
            sleep 1
        fi
    done

    ejecutarInstalacion
}

main
