apt-get install g++

apt-get install cmake

apt-get install make

apt-get install autoconf automake

apt-get install libncurses5-dev



curl -O http://cdn.mysql.com/Downloads/MySQL-5.6.17/mysql-5.6.17.tar.gz &

tar -zxvf mysql-5.6.17.tar.gz

mv mysql-5.6.17 mysql-5.6.17-src

cd mysql-5.6.17-src

cmake -DCMAKE_INSTALL_PREFIX=/home/uniweibo/mysql/mysql-5.6.17.UNISCRM -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS:STRING=utf8,utf8mb4,gbk -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DENABLED_LOCAL_INFILE=1 -DMYSQL_DATADIR=/home/uniweibo/mysql/mysql6606/data -DMYSQL_UNIX_ADDR=/tmp/mysql.6606.sock -DMYSQL_TCP_PORT=6606 -DSYSCONFDIR=/home/uniweibo/mysql/mysql6606/conf


make && make install

cd /home/uniweibo/mysql/mysql-5.6.17.UNISCRM


初始化数据：

./scripts/mysql_install_db --datadir=/home/uniweibo/mysql/mysql6606/data --defaults-file=/home/uniweibo/mysql/mysql6606/conf/my.cnf



启动：
/home/uniweibo/mysql/mysql-5.6.17.UNISCRM/bin/mysqld_safe --defaults-file=/home/uniweibo/mysql/mysql6606/conf/my.cnf --explicit_defaults_for_timestamp=true --socket=/tmp/mysql.6606.sock  &


登录：
bin/mysql -h127.0.0.1 -uroot -P6606

创建db：

create database uniweibo_v2
grant all on uniweibo_v2.* to uniweibo@'%' identified by 'uniweibo.com';





暂停：
/home/uniweibo/mysql/mysql-5.6.17.UNISCRM/bin/mysqladmin --defaults-file=/home/uniweibo/mysql/mysql6606/conf/my.cnf -uroot -p --socket=/tmp/mysql.6606.sock shutdown
