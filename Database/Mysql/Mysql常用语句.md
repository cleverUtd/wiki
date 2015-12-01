### 导出数据

mysqldump -h -u -p -P　-t 数据库名 >　xxx.sql

### 导出结构

mysqldump --opt -d 数据库名 -hlocalhost -uroot -p123 -P3306 > xxx.sql

### 导出数据和结构

mysqldump -h -u -p -P database table > dump.sql


### 导入数据

mysql 数据库名 < 文件

或者

在连接mysql后 source  ×××.sql



### 客户端select结果导出到文件

mysql -hxx -uxx -pxx -e "query statement" db > file



### 执行授权命令

GRANT ALL PRIVILEGES ON *.* TO root@my_ip IDENTIFIED BY ‘root_password‘ WITH GRANT OPTION;



