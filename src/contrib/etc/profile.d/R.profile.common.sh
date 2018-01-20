#R.profile.common.sh
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# [   C o m m o n   R   S h e l l   E n v i r o n m e n t   ]
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#
#  C u r r e n t   R   V e r s i o n
export R_VER=3.3
#
#
#----- Don't change below this line ------
#
if [ "X${0:0:1}" = "X-" ]; then
    _SCRIPT=""
    if [ "X$0" = "X-bash" ]; then
        _SCRIPT=$(readlink -mnq "${BASH_SOURCE}")
    fi
    if [ "X$0" = "X-ksh" ]; then
        _SCRIPT=$(readlink -mnq "${.sh.file}")
    fi
    if [ "X${_SCRIPT}" = "X" ]; then
        echo "error: unsupported shell (${SHELL})" >&2
    else
        if [ ! "X$1" = "X" ]; then
            export R_VER="$1"
        fi
        _PROFILE_DIR=$(dirname "${_SCRIPT}")
        if [ -r "${_PROFILE_DIR}/R.profile.common.functions.sh" ]; then
            source "${_PROFILE_DIR}/R.profile.common.functions.sh"
        fi
        if [ -r "${_PROFILE_DIR}/R.profile.common.variables.sh" ]; then
            source "${_PROFILE_DIR}/R.profile.common.variables.sh"
        fi
        echo
        echo "Shell environment set for R-${R_VER}"
        echo "R.home() is set to '${RHOME}'"
        echo
    fi
else
    _SCRIPT=$(readlink -mnq "$0")
    echo "error: script '${_SCRIPT}' is to be sourced and not executed" >&2
fi
#
# End of file
