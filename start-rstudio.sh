#!/bin/bash
#/usr/lib/rstudio-server/bin/rserver --server-daemonize 0
. ./functions.sh

rserver="/usr/lib/rstudio-server/bin/rserver"
prog=$(basename $rserver)
lockfile=/var/lock/subsys/rstudio-server

# Exit if the package is not installed
[ -x "$rserver" ] || exit 0

start() {
    echo -n $"Starting rstudio-server: "
    daemon $rserver
    retval=$?
    echo
    [ $retval -eq 0 ] && touch $lockfile
    return $retval
}

stop() {
    echo -n $"Stopping rstudio-server: "
    killproc $prog
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f $lockfile
    return $retval
}

restart() {
    stop
    sleep 1
    start
}

rh_status() {
    status $prog
}

rh_status_q() {
    rh_status >/dev/null 2>&1
}

case "$1" in
    start)
        rh_status_q && exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart)
        $1
        ;;
    status)
        rh_status
        ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart}"
        exit 2
esac


exit 0
