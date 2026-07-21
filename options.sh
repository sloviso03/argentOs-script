#!/usr/bin/env bash

declare -A LENGUAJES_MAP=(
    ["C# / .NET"]="dotnet"
    ["Node.js"]="node"
    ["Python"]="python"
    ["Go"]="go"
    ["Rust"]="rust"
    ["Java"]="java"
)


OPCIONES=(
    "C# / .NET"
    "Node.js"
    "Python"
    "Go"
    "Rust"
    "Java"
)

ELEGIDOS=()


mostrarMenu() {
    clear
    echo "=========================================="
    echo "       ArgentOs Developer Setup           "
    echo "=========================================="
    echo "¿Qué lenguajes/entornos querés instalar che?"
    echo ""

    for i in "${!OPCIONES[@]}"; do
        local lenguaje="${OPCIONES[$i]}"
        local estado=" "

        if [[ " ${ELEGIDOS[*]} " =~ " ${lenguaje} " ]]; then
            estado="*"
        fi

        printf "%2d. [%c] %s\n" "$((i+1))" "$estado" "$lenguaje"
    done

    echo ""
    printf "%2d. Seleccionar TODOS\n" "$(( ${#OPCIONES[@]} + 1 ))"
    printf "%2d. Limpiar selección\n" "$(( ${#OPCIONES[@]} + 2 ))"
    printf "%2d. Confirmar e instalar\n" "$(( ${#OPCIONES[@]} + 3 ))"
    printf "%2d. Salir\n" "$(( ${#OPCIONES[@]} + 4 ))"
    echo ""
}

ejecutarInstalacion() {
    clear
    if [ ${#ELEGIDOS[@]} -eq 0 ]; then
        echo "No seleccionaste ningún lenguaje. Saliendo..."
        exit 0
    fi

    echo "=========================================="
    echo " Iniciando instalación de herramientas..."
    echo "=========================================="
    echo ""

    for nombre_visible in "${ELEGIDOS[@]}"; do
        local plugin="${LENGUAJES_MAP[$nombre_visible]}"
        echo "--> Instalando y configurando $nombre_visible ($plugin)..."
        mise use -g "${plugin}@latest"

        echo "✓ $nombre_visible listo."
        echo "------------------------------------------"
    done


    mise reshim

    echo ""
    echo "=========================================="
    echo " ¡Configuración completada con éxito!"
    echo "=========================================="
    echo ""
}

main() {
    local total=${#OPCIONES[@]}
    local opc_todos=$((total + 1))
    local opc_limpiar=$((total + 2))
    local opc_confirmar=$((total + 3))
    local opc_salir=$((total + 4))

    while true; do
        mostrarMenu
        read -p "Elige una opción: " entrada

        if [[ "$entrada" == "$opc_salir" ]]; then
            echo "Operación cancelada."
            exit 0
        elif [[ "$entrada" == "$opc_confirmar" ]]; then
            break
        elif [[ "$entrada" == "$opc_todos" ]]; then
            ELEGIDOS=("${OPCIONES[@]}")
        elif [[ "$entrada" == "$opc_limpiar" ]]; then
            ELEGIDOS=()
        elif [[ "$entrada" -gt 0 && "$entrada" -le "$total" ]] 2>/dev/null; then
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
