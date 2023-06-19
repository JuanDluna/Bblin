#!/bin/bash

# Función para mostrar el "File chooser"
mostrar_file_chooser() {
    echo "Por favor, ingresa la ruta del archivo que deseas editar:"
    read -e archivo

    # Verificar si el archivo existe
    if [[ -f "$archivo" ]]; then
        echo "Archivo encontrado: $archivo"
    else
        echo "El archivo no existe."
        exit 1
    fi
}

# Función para mostrar el archivo en terminal
mostrar_archivo() {
    archivo="$1"

    # Verificar si el archivo existe
    if [[ -f "$archivo" ]]; then
        echo "Contenido del archivo:"
        cat "$archivo"
    else
        echo "El archivo no existe."
        exit 1
    fi
}

# Función para editar el archivo
editar_archivo() {
    archivo="$1"

    # Verificar si el archivo existe
    if [[ -f "$archivo" ]]; then

        # Crear un archivo temporal para la edición
        tmpfile=$(mktemp)
        cp "$archivo" "$tmpfile"

        # Abrir el archivo temporal para la edición
        ./fileEditor.sh "$tmpfile"

        # Mover el archivo editado a su ubicación original
        mv "$tmpfile" "$archivo"

        echo "El archivo ha sido editado y guardado."
    else
        echo "El archivo no existe."
        exit 1
    fi
}

# Función principal
main() {
    # Verificar si se pasó un archivo por parámetro
    if [[ -n $1 ]]; then
        archivo="$1"
        mostrar_archivo "$archivo"
    else
        mostrar_file_chooser
    fi

    editar_archivo "$archivo"
}

# Validar el número de parámetros antes de llamar a main
if [[ $# -gt 1 ]]; then
    echo "Error: Demasiados parámetros. Se espera solo un archivo como parámetro."
    exit 1
fi

# Llamada a la función principal
main "$@"
