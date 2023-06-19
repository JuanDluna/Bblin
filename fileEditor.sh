#!/bin/bash

# Función principal del editor de texto
editor() {
    archivo="$1"

    # Verificar si el archivo existe
    if [[ -f "$archivo" ]]; then
        # Leer el contenido del archivo
        contenido=$(cat "$archivo")

        # Mostrar el contenido del archivo
        mostrar_contenido "$contenido"

        # Loop principal del editor
        while true; do
            mostrar_menu
            read -p "Selecciona una opción: " opcion
            procesar_opcion "$opcion" "$archivo"
        done
    else
        echo "El archivo no existe."
        exit 1
    fi
}

# Función para mostrar el contenido del archivo
mostrar_contenido() {
    contenido="$1"
    echo "Contenido del archivo:"
    echo "$contenido"
}

# Función para mostrar el menú de opciones
mostrar_menu() {
    echo "------------- MENÚ -------------"
    echo "1. Buscar texto"
    echo "2. Reemplazar texto"
    echo "3. Guardar archivo"
    echo "4. Salir"
    echo "--------------------------------"
}

# Función para procesar la opción seleccionada
procesar_opcion() {
    opcion="$1"
    archivo="$2"

    case $opcion in
        1)
            buscar_texto "$archivo"
            ;;
        2)
            reemplazar_texto "$archivo"
            ;;
        3)
            guardar_archivo "$archivo"
            ;;
        4)
            exit 0
            ;;
        *)
            echo "Opción inválida. Por favor, selecciona una opción válida."
            ;;
    esac
}

# Función para buscar texto en el archivo
buscar_texto() {
    archivo="$1"

    read -p "Ingresa el texto a buscar: " texto

    # Realizar la búsqueda en el archivo
    resultado=$(grep -n "$texto" "$archivo")

    if [[ -n "$resultado" ]]; then
        echo "Coincidencias encontradas:"
        echo "$resultado"
    else
        echo "No se encontraron coincidencias."
    fi
}

# Función para reemplazar texto en el archivo
reemplazar_texto() {
    archivo="$1"

    read -p "Ingresa el texto a reemplazar: " texto_buscar
    read -p "Ingresa el nuevo texto: " texto_reemplazar

    # Realizar el reemplazo en el archivo
    sed -i "s/$texto_buscar/$texto_reemplazar/g" "$archivo"

    echo "El texto ha sido reemplazado correctamente."
}

# Función para guardar el archivo
guardar_archivo() {
    archivo="$1"

    echo "Guardando el archivo..."
    # Implementa aquí la lógica para guardar el archivo en su ubicación original

    echo "El archivo ha sido guardado."
}

# Llamada a la función principal
editor "$@"
