解决依赖关系

==

 

1.   pcre库 （为支持http rewrite模块，支持正则表达式）

            wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.34.tar.gz

            tar -zxvf pcre-8.34.tar.gz

            cd pcre-8.34

            ./configure

            make

            make install

2.  zlib

            wget http://zlib.net/zlib-1.2.8.tar.gz

            tar -zxvf zlib-1.2.8.tar.gz

            cd zlib-1.2.8

            ./configure

            make

            make install

3. openSSl



编译安装nginx

==

       

    cd /home/unicat/nginx

    

    tar zxvf nginx-1.9.3.tar.gz

    

    mv nginx-1.9.3 nginx-1.9.3-src

    

    cd nginx-1.9.3-src

    

    ./configure --prefix=/home/unicat/nginx/nginx-1.9.3 --with-http_dav_module --with-http_flv_module --with-http_realip_module --with-http_gzip_static_module --with-http_stub_status_module --with-debug

    

    make

    

    make install

