#!/bin/bash

# Función para mostrar el "File chooser"
mostrar_file_chooser() {
    archivo=$(dialog --stdout --title "Por favor, selecciona el archivo que deseas editar" --fselect $HOME/ 14 48)

    # Verificar si el archivo existe
    if test -f "$archivo"; then
        dialog --title "Archivo encontrado" --msgbox "Archivo encontrado: $archivo" 6 44
    else
        dialog --title "Error" --msgbox "El archivo no existe." 6 44
        exit 1
    fi
}

# Función para editar el archivo
editar_archivo() {
    # Lógica de edición del archivo
    contenido=$(cat "$archivo")
    tmpfile=$(mktemp)
    echo "$contenido" > $tmpfile
    nuevo_contenido=$(dialog --stdout --title "Editando $archivo" --editbox $tmpfile 0 0)
    rm $tmpfile
    echo "$nuevo_contenido" > "$archivo"
}

# Función principal
main() {
    # Verificar el número de parámetros
    if [[ $# -gt 1 ]]; then
        dialog --title "Error" --msgbox "Error: Demasiados parámetros. Se espera solo un archivo como parámetro." 6 44
        exit 1
    fi

    # Verificar si se pasó un archivo por parámetro
    if [[ -n $1 ]]; then
        archivo="$1"
        # Verificar si el archivo existe
        if test -f "$archivo"; then
            dialog --title "Archivo encontrado" --msgbox "Archivo encontrado: $archivo" 6 44
        else
            dialog --title "Error" --msgbox "El archivo no existe." 6 44
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
    dialog --title "Error" --msgbox "Error: Demasiados parámetros. Se espera solo un archivo como parámetro." 6 44
    exit 1
fi

# Llamada a la función principal
main "$@"
