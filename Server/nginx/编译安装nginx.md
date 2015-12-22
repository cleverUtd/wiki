解决依赖关系
==

1. pcre库 （为支持http rewrite模块，支持正则表达式）

    wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz

    tar -zxvf pcre-8.38.tar.gz

    cd pcre-8.38

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

    wget http://nginx.org/download/nginx-1.9.3.tar.gz
    
    tar zxvf nginx-1.9.3.tar.gz

    mv nginx-1.9.3 nginx-1.9.3-src

    cd nginx-1.9.3-src

    ./configure --prefix=/home/unicat/nginx/nginx-1.9.3 --with-http_dav_module --with-http_flv_module --with-http_realip_module --with-http_gzip_static_module --with-http_stub_status_module --with-debug

    make

    make install


安装nginx第三模块
==

```
#./configure --prefix=/home/unicat/nginx/nginx-1.9.3 \
--with-http_stub_status_module \
--with-http_ssl_module --with-http_realip_module \
--with-http_image_filter_module \
--add-module=/第三方模块目录
# make
# /home/unicat/nginx/nginx-1.9.3/sbin/nginx -s stop
# cp objs/nginx /usr/local/nginx/sbin/nginx
# /home/unicat/nginx/nginx-1.9.3/sbin/nginx
```

安装第三方模块实际上是使用 --add-module 重新安装一次 nginx,不要 make install 而是直接把编译目录下 objs/nginx 文件直接覆盖老的 nginx 文件.如果需要安装多个 nginx 第三方模块,只需要多指定几个相应的--add-module 即可.

PS:重新编译的时候,记得一定要把以前编译过的模块一同加到 configure 参数里面