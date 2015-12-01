
#添加tomcat参数 /bin/catalina.sh



    export JAVA_OPTS="$JAVA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n"



    'dt_shmem' 和 'dt_socket' ，分别表示本机调试和远程调试。



#启动tomcat 使用的命令行参数



    startup.sh jpda start



#配置 Eclipse



    Run ——> Debug Configurations ——> Add Remote Java Application ——> 添加一下，然后配置，确认后 apply 即可



#按键操作：



    1、F5键与F6键均为单步调试，F5是进入本行代码中执行，F6是执行本行代码，跳到下一行；

    2、F7是跳出函数；

    3、F8是执行到最后。 



#debug.sh | debug bat

    

```bash```

cd %CATALINE_HOME%/bin

set JPDA_ADDRESS=8787

set JPDA_TRANSPORT=dt_socket

set CATALINA_OPTS=-server -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787

startup 

```