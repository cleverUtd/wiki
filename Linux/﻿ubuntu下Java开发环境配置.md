

安装jdk

==



1.[下载 jdk](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)，解压文件

 

    sudo mkdir jdk

    sudo tar zxvf jdk-8u51-linux-x64.tar.gz -C /home/unicat/jdk



2.添加环境变量



    sudo vim ~/.bashrc



在bashrc文件中添加以下4行



    export JAVA_HOME=/home/unicat/jdk/jdk1.8.0_51

    export JRE_HOME=${JAVA_HOME}/jre

    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib

    export PATH=${JAVA_HOME}/bin:$PATH



3.配置默认JDK版本



    sudo update-alternatives –install /usr/bin/java java /home/unicat/jdk/jdk1.8.0_51/bin/java 300



    sudo update-alternatives –install /usr/bin/javac javac /home/unicat/jdk/jdk1.8.0_51/bin/javac 300



    sudo update-alternatives –install /usr/bin/jar jar /home/unicat/jdk/jdk1.8.0_51/bin/jar 300



    sudo update-alternatives –install /usr/bin/javah javah /home/unicat/jdk/jdk1.8.0_51/bin/javah 300



    sudo update-alternatives –install /usr/bin/javap javap /home/unicat/jdk/jdk1.8.0_51/bin/javap 300



4.运行 java -version 命令，如果正确输出版本号，说明安装成功



安装maven

==

## 注意： 安装maven前请先安装好jdk



1.[下载maven](http://maven.apache.org/download.cgi)



2.解压：

    

    tar -zxvf apache-maven-3.3.3-bin.tar.gz -C /home/unicat/maven



3.设置环境变量



    sudo vim /etc/profile



    在profile文件下加入如下内容

    #set maven environment

    M2_HOME=/home/unicat/maven/apache-maven-3.3.3

    export MAVEN_OPTS=”-Xms256m -Xmx512m”

    export PATH=$M2_HOME/bin:$PATH



4.配置用户范围setting.xml



    cp conf/settings.xml ~/.m2/



    在settings.xml文件如下位置后添加

    <!– localRepository

    | The path to the local repository maven will use to store artifacts.

    |

    | Default: ${user.home}/.m2/repository

    <localRepository>/path/to/local/repo</localRepository>

    –>

    <localRepository>/home/unicat/repository/maven</localRepository>



安装eclipse

==



1.[下载](https://www.eclipse.org/downloads)



2.解压

    

    tar zxvf  eclipse-jee-mars-R-linux-gtk-x86_64.tar.gz -C /home/unicat/eclipse



3.给eclipse创建启动栏图标



sudo vim /usr/share/applications/ecljiaipse.desktop



    [Desktop Entry]

    Comment=Java IDE

    Name=Eclipse

    Exec=/home/unicat/eclipse/eclipse-mars

    Encoding=UTF-8

    Terminal=false

    Type=Application

    Categories=Application;Development;

    Icon=/home/unicat/eclipse/eclipse-mars/icon.xpm



安装sublime

==



    sudo add-apt-repository ppa:webupd8team/sublime-text-3

    sudo apt-get update

    sudo apt-get install sublime-text-installer



