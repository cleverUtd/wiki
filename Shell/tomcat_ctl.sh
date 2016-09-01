#!/bin/bash

# This shell if for starting and stopping Tomcat

usage() {
    echo 'Usage :   start or stop tomcat.'
    echo 'param :   start|stop|restart|status'
    exit 1
}

#set -x

TOMCAT=$2

SHUTDOWN_WAIT=45

#PID=''

tomcat_pid() {
   echo `ps -ef | grep ${TOMCAT} | grep -v grep | grep -v $0 | awk '{print $2}'`
}

start() {
    pid=$(tomcat_pid)
    if [ -n "${pid}" ]
    then
	echo "========================================================================"
        echo "[ ${TOMCAT} ] is already running (pid: ${pid})"
	echo "========================================================================"
    else
        # start 
	echo "========================================================================"
        echo "Starting tomcat [ ${TOMCAT} ]"
	echo "========================================================================"
        ${TOMCAT}/bin/startup.sh
        #tail -f ${TOMCAT}/logs/catalina.out
    fi
}

stop() {
    pid=$(tomcat_pid)

    if [ -n "${pid}" ]
    then
        echo "========================================================================"
        echo "stopping tomcat [ ${TOMCAT} ], pid=${pid}"
  	echo "========================================================================"
        sh ${TOMCAT}/bin/shutdown.sh
	kill ${pid}

    let kwait=${SHUTDOWN_WAIT}
    count=0
    count_by=5
    while [ `ps -p ${pid} | grep -c ${pid}` -gt 0 ] && [ ${count} -lt ${kwait} ];
    do
	echo "================================================================================="
        echo "Waiting for processes to exit. Timeout before we kill the pid: ${count}/${kwait} "
	echo "================================================================================="
        sleep ${count_by}
        let count=${count}+${count_by};
    done

    if [ ${count} -gt ${kwait} ]; then
	echo "========================================================================"
        echo "Killing processes which didn't stop after ${SHUTDOWN_WAIT} seconds"
	echo "========================================================================"
        kill -9 ${pid}
    fi
    else 
	echo "======================================================================="
        echo "[ ${TOMCAT} ] is not running"
	echo "======================================================================="
    fi
}

#echo $1 $2

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
        if [ -n "${pid}" ]
        then
            echo "[ ${TOMCAT} ] is running with pid: ${pid}"
        else
            echo "[ ${TOMCAT} ]is not running"
        fi
        ;;
    *)
        usage
        ;;
esac

