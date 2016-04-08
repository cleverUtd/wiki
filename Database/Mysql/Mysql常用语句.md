dump
==

### 导出包括系统数据库在内的所有数据库

mysqldump -uroot -proot --all-databases > all.sql

### 导出db1、db2两个数据库的所有数据

mysqldump -uroot -proot --databases db1 db2 > all.sql

### 导出db1中的a1、a2表

mysqldump -uroot -proot --databases db1 --tables a1 a2  > db1.sql

### 条件导出，导出db1表a1中id=1的数据
条件导出只能导出单个表
mysqldump -uroot -proot --databases db1 --tables a1 --where='id=1'  > a1.sql

### 生成新的binlog文件,-F
有时候会希望导出数据之后生成一个新的binlog文件,只需要加上-F参数
mysqldump -uroot -proot --databases db1 -F >/tmp/db1.sql

### 只导出表结构不导出数据，–no-data

mysqldump -uroot -proot --no-data --databases db1 > /tmp/db1.sql

### 导入数据

mysql 数据库名 < 文件

或者

在连接mysql后 source  ×××.sql

### 客户端select结果导出到文件

mysql -hxx -uxx -pxx -e "query statement" db > file

### 执行授权命令

GRANT ALL PRIVILEGES ON *.* TO root@my_ip IDENTIFIED BY ‘root_password‘ WITH GRANT OPTION;



