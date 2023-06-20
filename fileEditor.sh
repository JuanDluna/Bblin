#!/bin/bash
archivo=$1

# Función para editar el archivo
# Función para editar el archivo
editar_archivo() {
    # Lógica de edición del archivo
    contenido=$(cat "$archivo")
    tmpfile=$(mktemp)
    echo "$contenido" > $tmpfile
    nuevo_contenido=$(dialog --stdout --title "Editando $archivo" --editbox $tmpfile 0 0)
    exit_status=$?
    rm $tmpfile
    if [[ $exit_status -eq 0 ]]; then
        echo "$nuevo_contenido" > "$archivo"
    else
        dialog --title "Operación cancelada" --msgbox "La operación fue cancelada. El archivo no fue modificado." 6 44
    fi
}


# Función principal
main() {
    editar_archivo
}

# Llamada a la función principal
main 

clear