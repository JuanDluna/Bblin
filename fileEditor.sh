#!/bin/bash
source simple_curses.sh

archivo=$1

main(){
    # create a window
    window "Editor de texto" "blue" "100%"
        append_command "less $archivo"
    endwin

}

main_loop