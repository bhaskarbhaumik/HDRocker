#!/bin/bash

_col_red=$(tput setaf 1)
_col_green=$(tput setaf 2)
_col_yellow=$(tput setaf 3)
_col_blue=$(tput setaf 4)
_col_magenta=$(tput setaf 5)
_col_cyan=$(tput setaf 6)
_col_white=$(tput setaf 7)
_col_bright=$(tput bold)
_col_normal=$(tput sgr0)
_col_blink=$(tput blink)
_col_reverse=$(tput smso)
_col_underline=$(tput smul)

function msg() {
    echo "${_col_bright}${_col_yellow}$*${_col_normal}"
}

function status() {
    _rc=$1; shift
    echo -n "${_col_bright}${_col_blue}$*${_col_normal} .....  "
    if [ ! "X${_rc}" = "X0" ]; then
        echo "${_col_bright}${_col_green}SUCCESS!${_col_normal}"
    else
        echo "${_col_bright}${_col_red}FAILED!${_col_normal}"
    fi
}
