获得系统的状态报告

==

```

redis-cli info

```



#内存使用



1. used_memory：使用了多少内存

2. used_memory_peak：内存峰值



#持久化



1. rdb_last_save_time：最近一次dump数据操作的时间

2. rdb_changes_since_last_save：对上一次持久化之后更新了多少数据；可以知道如果这时候出现故障，你会丢失多少数据。



#主从复制



1. master_link_statu: 如果这个值是up，说明同步正常；如果是down，这时需要注意一下输出的其他一些诊断信息，

例如：

```

role:slave master_host:192.168.1.128 master_port:6379 master_link_status:down master_last_io_seconds_ago:-1 master_sync_in_progress:0 master_link_down_since_seconds:1356900595

```



#配置一致



    Redis 支持使用 CONFIG SET 操作来实现运行实的配置修改，这很方便，但同时也会导致一个问题。就是通过这个命令动态修改的配置，是不会同步到你的配置文件中去的。所以当你因为某些原因重启 Redis 时，你使用 CONFIG SET 做的配置修改就会丢失掉，所以我们最好保证在每次使用 CONFIG SET 修改配置时，也把配置文件一起相应地改掉。为了防止人为的失误，所以我们最好对配置进行监控，使用 CONFIG GET 命令来获取当前运行时的配置，并与 redis.conf 中的配置值进行对比。



#慢日志



    Redis 提供了 SLOWLOG 指令来获取最近的慢日志，Redis 的慢日志是直接存在内存中的，所以它的慢日志开销并不大，在实际应用中，我们通过 crontab 任务执行 SLOWLOG 命令来获取慢日志，然后将慢日志存到文件中，并用 Kibana 生成实时的性能图表来实现性能监控。

    值得一提的是，Redis 的慢日志记录的时间，仅仅包括 Redis 自身对一条命令的执行时间，不包括 IO 的时间，比如接收客户端数据和发送客户端数据这些时间。另外，Redis的慢日志和其它数据库的慢日志有一点不同，其它数据库偶尔出现 100ms 的慢日志可能都比较正常，因为一般数据库都是多线程并发执行，某个线程执行某个命令的性能可能并不能代表整体性能，但是对Redis来说，它是单线程的，一旦出现慢日志，可能就需要马上得到重视，最好去查一下具体是什么原因了。



slowlog get: 列出所有slow log 



slowlog get N:列出最近N条slow log





```

redis 127.0.0.1:6379> slowlog get 2

1) 1) (integer) 14

   2) (integer) 1309448221

   3) (integer) 15

   4) 1) "ping"

2) 1) (integer) 13

   2) (integer) 1309448128

   3) (integer) 30

   4) 1) "slowlog"

      2) "get"

      3) "100"

```



    每个条目由4个字段构成： 

    1）用于表示该条slow log的唯一id 

    2）以unix时间戳表示的日志记录时间 

    3）命令执行时间，单位：微秒 

    4） 执行的具体命令 

    只有当reids重启后，id编号才会被重置。



#监控服务



1. Sentinel



    redis 主从监控工具，并实现主挂掉之后的自动故障转移。在转移的过程中，它还可以被配置去执行一个用户自定义的脚本，在脚本中我们就能够实现报警通知等功能。



2. [Redis Live](https://github.com/nkrode/RedisLive)



    更通用的 Redis 监控方案。定时在 Redis 上执行 MONITOR 命令，获取当前 Redis 当前正在执行的命令，并通过统计分析，生成web页面的可视化分析报表。



3. [Redis Faina](https://github.com/facebookarchive/redis-faina)

    

     instagram 开发的 Redis 监控服务，原理和 Redis Live 类似



#数据分布



    对 Redis 的数据集进行分析。比如想知道哪类型的 key 值占用内存最多。



1. [Redis-sampler](https://github.com/antirez/redis-sampler)

    

    Redis作者开发的工具，通过采样的方法，能够让你了解当前Redis中的数据的大致类型，以及数据分布状况



2. [Redis-audit](https://github.com/snmaynard/redis-audit)



    是一个脚本，通过它可以知道每一类key对内存的使用量。它可以提供的数据有：某一类 key值的访问频率如何，有多少值设置了过期时间，某一类key值使用内存的大小，这很方便让我们能排查哪些 key 不常用或者压根不用



3. [Redis-rdb-tools](https://github.com/sripathikrishnan/redis-rdb-tools)

    

    跟 Redis-audit 功能类似，不同的是它是通过对 rdb 文件进行分析来取得统计数据的。

