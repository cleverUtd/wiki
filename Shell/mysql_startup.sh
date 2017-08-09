#SH_DIR=$(dirname $(which $0))
#. $SH_DIR/app_env.sh

MYSQL_BASE=/apps/svr/mysql5
MYSQL_CONF=/apps/conf/mysql

export PATH=$MYSQL_BASE/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LD_LIBRARY_PATH=$MYSQL_BASE/lib


if [ "$1" = "stop"  ] ; then
    $MYSQL_BASE/bin/mysqladmin --defaults-file=$MYSQL_CONF/mysql5_3308.cnf  shutdown
elif [ "$1" = "restart"  ]; then
    $MYSQL_BASE/bin/mysqladmin  --defaults-file=$MYSQL_CONF/mysql5_3308.cnf  shutdown
    $MYSQL_BASE/bin/mysqld_safe --defaults-file=$MYSQL_CONF/mysql5_3308.cnf &
elif [ "$1" = "start"  ]; then
    $MYSQL_BASE/bin/mysqld_safe --defaults-file=$MYSQL_CONF/mysql5_3308.cnf &
else
    echo "usage: $0 start|stop|restart"
fi
