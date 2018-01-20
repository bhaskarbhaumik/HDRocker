#changeR.ksh
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# S c r i p t   f o r   c h a n g i n g / s e t t i n g   R   e n v i r o n m e n t
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#
_R_BASE=/opt/isv/R-base
_R_DEFAULT=/opt/isv/R

_R_DEFAULT_VER=$(readlink -mnq $_R_DEFAULT 2>/dev/null)
_R_DEFAULT_VER=${_R_DEFAULT_VER##*/}
_R_VER=$_R_DEFAULT_VER

typeset -i _i=0
typeset -i _j=0
typeset -i _N_R_PKG_VERS=0
typeset -a _R_PKG_VERS

export _R_PKG_VERS=($(find $_R_BASE -maxdepth 1 -name 'R-*.*.*' -printf "%f\n" 2>/dev/null | sort -u | tr '\n' ' ' | sed 's/[ ]*$//g'))
export _N_R_PKG_VERS=${#_R_PKG_VERS[*]}

printf "Following versions of R are present in this server:\n"
for (( _i=0; _i < _N_R_PKG_VERS; _i++ )); do
    _j=$(expr $_i + 1)
    printf "\t[%1d] %s\n" $_j ${_R_PKG_VERS[$_i]}
done

read _opt?"Which R Version you want to use? [choose a number]: "
echo

if [ "X$_opt" = "X" ]; then
    _R_VER=$_R_DEFAULT_VER
    echo "Nothing entered. Env for default '$_R_VER' will be set." >&2
else
    _x=`echo "$_opt" | tr -d '[:digit:]'`
    if [ "X$_x" = "X" ]; then
        if [[ $_opt -ge 1 && $_opt -le $_N_R_PKG_VERS ]]; then
            _i=$(expr $_opt - 1)
            _R_VER=${_R_PKG_VERS[$_i]}
            echo "Option $_opt entered. Env for '$_R_VER' will be set." >&2
        else
            _R_VER=$_R_DEFAULT_VER
            echo "Option $_opt is not listed. Env for default '$_R_VER' will be set." >&2
        fi
    else
        _R_VER=$_R_DEFAULT_VER
        echo "Option '$_opt' is not recognized. Env for default '$_R_VER' will be set." >&2
    fi
fi

if [ -r ${_R_BASE}/contrib/etc/profile.d/R.profile.common.sh ]; then
    . ${_R_BASE}/contrib/etc/profile.d/R.profile.common.sh ${_R_VER:2}
fi
#
#End of File
