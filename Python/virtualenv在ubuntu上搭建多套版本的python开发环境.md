### 官网

[virtualenv](http://www.virtualenv.org/en/latest/)



### 用途

virtualenv 是一个创建独立python环境的工具。其要解决的最基本问题就是库的依赖和版本



### 使用

安装

    

    sudo apt-get install python-virtualenv

创建虚拟环境



    virtualenv -p /usr/bin/python3 py3env



激活



    source py3env/bin/activate

    这时shell的提示符行前多了(py3env)字样，这样你就可以放心的使用python3做开发了

退出python3虚拟环境

    

    deactivate