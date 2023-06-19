#!/bin/bash
source simple_curses.sh

main(){
    # create a window
    window "Editor de texto" "blue" "100%"
        append_command "less $1"
    endwin

}

main_loop $1