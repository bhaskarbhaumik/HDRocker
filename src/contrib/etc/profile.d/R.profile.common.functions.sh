#R.profile.common.functions.sh
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# [   C o m m o n   R   S h e l l   E n v i r o n m e n t   ]
# [                 F U N C T I O N S                       ]
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#
# Define Functions
#
_setPath () {
    export PATH="$1"
}

_setLibs () {
    export LD_LIBRARY_PATH="$1"
    export LIBRARY="${LD_LIBRARY_PATH}"
    export LIBPATH="${LD_LIBRARY_PATH}"
}

_addPath () {
    if ! echo "${PATH}" | /bin/egrep -q "(^|:)$1($|:)" ; then
        if [ -d "$1" ]; then
            if [ "$2" = "after" ] ; then
                export PATH="${PATH}:$1"
            else
                export PATH="$1:${PATH}"
            fi
        fi
    fi
}

_addLibs () {
    if ! echo "${LD_LIBRARY_PATH}" | /bin/egrep -q "(^|:)$1($|:)" ; then
        if [ -d "$1" ]; then
            if [ "$2" = "after" ] ; then
                export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$1"
            else
                export LD_LIBRARY_PATH="$1:${LD_LIBRARY_PATH}"
            fi
            export LIBRARY="${LD_LIBRARY_PATH}"
            export LIBPATH="${LD_LIBRARY_PATH}"
        fi
    fi
}
#
# End of file
