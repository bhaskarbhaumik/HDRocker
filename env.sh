#!/bin/bash

[ "Y${_ENV_DEFINED}" = "Yes" ] && return
export _ENV_DEFINED="es"

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
    echo "[TASK] ${_col_bright}${_col_underline}${_col_yellow}`echo "$*" | sed -r 's/(.)/\1 /g'`${_col_normal}"
}

function status() {
    _rc=$1; shift
    echo -n "[STATUS] ${_col_bright}${_col_cyan}$*${_col_normal} .....  "
    if [ ! "X${_rc}" = "X0" ]; then
        echo "${_col_bright}${_col_red}FAILED!${_col_normal} [RC=${_rc}]"
        exit ${_rc}
    else
        echo "${_col_bright}${_col_green}SUCCESS!${_col_normal}"
    fi
}

function gitpull() {
    _pkg="$1"
    curl -sLk "https://github.com/bhaskarbhaumik/hdrocker-binres/blob/master/${_pkg}?raw=true" -o "${_pkg}"
    status $? "Download '${_pkg}' from GitHub"
}
