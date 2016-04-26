#!/bin/bash

# This shell if for starting and stopping Tomcat

usage() {
    echo 'Usage :   start or stop tomcat.'
    echo 'param :   start|stop|restart|status'
    exit 1
}

#set -x

TOMCAT="/home/unicat/tomcat/apache-tomcat-8.0.32"

SHUTDOWN_WAIT=45

tomcat_pid() {
    echo `ps -ef | grep ${TOMCAT} | grep -v grep | awk '{print $2}'`
}

start() {
    pid=$(tomcat_pid)
    if [ -n "$pid" ]
    then
        echo "Tomcat is already running (pid: $pid)"
    else
        # start 
        echo "Starting tomcat...${TOMCAT}"
        ${TOMCAT}/bin/startup.sh
        tail -f ${TOMCAT}/logs/catalina.out
    fi
    return 0
}

stop() {
    pid=$(tomcat_pid)
    if [ -n "$pid" ]
    then
        echo "stopping tomcat...${TOMCAT}"
        sh ${TOMCAT}/bin/shutdown.sh

    let kwait=${SHUTDOWN_WAIT}
    count=0
    count_by=5
    while [ `ps -p $pid | grep -c $pid` -gt 0 ] && [ $count -lt $kwait ];
    do
        echo "Waiting for processes to exit. Timeout before we kill the pid: ${count}/${kwait}"
        sleep $count_by
        let count=$count+$count_by;
    done

    if [ $count -gt $kwait ]; then
        echo "Killing processes which didn't stop after $SHUTDOWN_WAIT seconds"
        kill -9 $pid
    fi
    else 
        echo "Tomcat is not running"
    fi

    return 0
}

case $1 in 
    start)
        start
        ;;
    stop)
        stop 
        ;;
    restart)
        stop
        start
        ;;
    status)
        pid=$(tomcat_pid)
        if [ -n "$pid" ]
        then
            echo "Tomcat is running with pid: $pid"
        else
            echo "Tomcat is not running"
        fi
        ;;
    *)
        usage
        ;;
esac

exit 0
