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

# Función para buscar una cadena en el archivo
buscar() {
    cadena=$(dialog --stdout --inputbox "Ingresa la cadena a buscar:" 0 0)
    if [[ -z $cadena ]]; then
        return
    fi

    if ! grep -q "$cadena" "$archivo"; then
        dialog --msgbox "No se encontró la cadena '$cadena' en el archivo." 0 0
        return
    fi

    # Contar el número de veces que la cadena se encuentra en el archivo
    num_ocurrencias=$(grep -o "$cadena" "$archivo" | wc -l)

    dialog --msgbox "Se encontró la cadena '$cadena' $num_ocurrencias veces en el archivo.\n Para salir de la siguiente ventana, presione Q" 0 0

    # Mostrar el contenido del archivo con la cadena buscada resaltada
    grep --color=always -C 9999999 "$cadena" "$archivo" | less -R
}


# Función para buscar y reemplazar una cadena en el archivo
buscar_y_reemplazar() {
    cadena=$(dialog --stdout --inputbox "Ingresa la cadena a buscar y reemplazar:" 0 0)
    if [[ -z $cadena ]]; then
        return
    fi

    if ! grep -q "$cadena" "$archivo"; then
        dialog --msgbox "No se encontró la cadena '$cadena' en el archivo." 0 0
        return
    fi

    reemplazo=$(dialog --stdout --inputbox "Ingresa la cadena de reemplazo:" 0 0)
    if [[ -z $reemplazo ]]; then
        return
    fi

    sed -i "s/$cadena/$reemplazo/g" "$archivo"
}

# Función para copiar una línea del archivo
copiar_linea() {
    # Mostrar un mensaje al usuario pidiéndole que recuerde el número de línea a copiar
    dialog --msgbox "Recuerda el número de línea que deseas copiar." 0 0

    # Mostrar el contenido del archivo con un índice al lado de cada línea
    tmpfile=$(mktemp)
    nl -ba -s ": " "$archivo" > $tmpfile
    dialog --textbox $tmpfile 0 0
    rm $tmpfile

    num_lineas=$(wc -l < "$archivo")
    linea=$(dialog --stdout --inputbox "Ingresa el número de línea a copiar (1-$num_lineas):" 0 0)
    if [[ -z $linea || ! $linea =~ ^[0-9]+$ || $linea -lt 1 || $linea -gt $num_lineas ]]; then
        return
    fi

    linea_copiada=$(sed "${linea}q;d" "$archivo")

    # Mostrar un mensaje al usuario indicándole la línea que eligió
    dialog --msgbox "Elegiste copiar la línea $linea: '$linea_copiada'" 0 0
}

# Función para pegar la línea copiada en el archivo
pegar_linea() {
    if [[ -z $linea_copiada ]]; then
        dialog --msgbox "No hay ninguna línea copiada." 0 0
        return
    fi

    num_lineas=$(wc -l < "$archivo")
    linea=$(dialog --stdout --inputbox "Ingresa el número de línea donde pegar (1-$num_lineas):" 0 0)
    if [[ -z $linea || ! $linea =~ ^[0-9]+$ || $linea -lt 1 || $linea -gt $num_lineas ]]; then
        return
    fi

    sed -i "${linea}i${linea_copiada}" "$archivo"
}

# Función para mostrar un menú de opciones después de hacer clic en "Aceptar"
# Función para mostrar un menú de opciones después de hacer clic en "Aceptar"
guardar() {
    opcion=$(dialog --stdout --title "Guardar" --menu "Selecciona una opción:" 0 0 0 \
        1 "Guardar" \
        2 "Guardar como")
    case $opcion in
        1)
            # Guardar el contenido actualizado en el archivo original
            echo "$nuevo_contenido" > "$archivo"
            ;;
        2)
            while true; do
                # Pedir al usuario que seleccione la ruta y el nombre del nuevo archivo
                nuevo_archivo=$(dialog --stdout --title "Guardar como" --fselect $HOME/ 14 48)
                # Verificar si el archivo ya existe
                if [ -e "$nuevo_archivo" ]; then
                    # Preguntar al usuario si desea sobrescribir el archivo
                    if dialog --stdout --title "Sobrescribir archivo" --yesno "El archivo ya existe. ¿Deseas sobrescribirlo?" 0 0; then
                        # Sobrescribir el archivo
                        echo "$nuevo_contenido" > "$nuevo_archivo"
                        break
                    fi
                else
                    # Guardar el contenido actualizado en el nuevo archivo
                    echo "$nuevo_contenido" > "$nuevo_archivo"
                    break
                fi
            done
            ;;
    esac
}


# Función para editar el archivo
editar_archivo() {
    # Lógica de edición del archivo
    while true; do
        contenido=$(cat "$archivo")
        tmpfile=$(mktemp)
        echo "$contenido" > "$tmpfile"
        nuevo_contenido=$(dialog --stdout --extra-button --extra-label "Opciones" --title "Editando $archivo" --editbox $tmpfile 0 0)
        exit_status=$?
        rm $tmpfile
        if [[ $exit_status -eq 0 ]]; then
            guardar
            break
        elif [[ $exit_status -eq 3 ]]; then
            dialog --title "Información" --msgbox "Los cambios realizados en la caja de edición no se guardarán." 0 0
            opcion=$(dialog --stdout --title "Opciones" --menu "Selecciona una opción:" 0 0 0 \
                1 "Buscar" \
                2 "Buscar y reemplazar" \
                3 "Copiar línea" \
                4 "Pegar línea" \
                5 "Salir")
            case $opcion in
                1)
                    buscar
                    ;;
                2)
                    buscar_y_reemplazar
                    ;;
                3)
                    copiar_linea
                    ;;
                4)
                    pegar_linea
                    ;;
                5)
                    break 2
                    ;;
            esac
        else
            break
        fi
    done
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
clear