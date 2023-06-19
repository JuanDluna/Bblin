#!/bin/bash
source simple_curses.sh

main(){
    # create a window
    window "Example" "blue" "50%"
        append "Hello world"
        addsep
        append "The date command"
        append_command "date"
    endwin

    # move on the next column
    col_right

    # and create another window
    window "Example 2" "red" "50%"
        append "Hello world"
        addsep
        append "The date command"
        append_command "date"
    endwin
}
main_loop