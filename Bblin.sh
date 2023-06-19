#!/bin/bash

# Función para mostrar el "File chooser"
mostrar_file_chooser() {
    echo "Por favor, ingresa la ruta del archivo que deseas editar:"
    read -e archivo

    # Verificar si el archivo existe
    if test -f "$archivo"; then
        echo "Archivo encontrado: $archivo"
    else
        echo "El archivo no existe."
        exit 1
    fi
}

# Función para editar el archivo
editar_archivo() {
    echo "Editando archivo: $archivo"
    # Lógica de edición del archivo
}

# Función principal
main() {
    # Verificar el número de parámetros
    if [[ $# -gt 1 ]]; then
        echo "Error: Demasiados parámetros. Se espera solo un archivo como parámetro."
        exit 1
    fi

    # Verificar si se pasó un archivo por parámetro
    if [[ -n $1 ]]; then
        archivo="$1"
        # Verificar si el archivo existe
        if test -f "$archivo"; then
            echo "Archivo encontrado: $archivo"
        else
            echo "El archivo no existe."
            exit 1
        fi
    else
        mostrar_file_chooser
    fi

    editar_archivo
    # Resto de la lógica de tu programa
}

# Validar el número de parámetros antes de llamar a main
if [[ $# -gt 1 ]]; then
    echo "Error: Demasiados parámetros. Se espera solo un archivo como parámetro."
    exit 1
fi

# Llamada a la función principal
main "$@"
