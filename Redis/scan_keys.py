import redis

pool = redis.ConnectionPool(host='127.0.0.1', port=6379, password='123')
r = redis.Redis(connection_pool=pool)

#len = 0
#key_list = []
for key in r.scan_iter(match='key_*', count=1000):
    #key_list.append(key)
    print key
