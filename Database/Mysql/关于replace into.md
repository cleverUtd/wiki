
> 跟 insert 功能类似，不同点在于：replace into 首先尝试插入数据到表中

     1. 如果发现表中已经有此行数据（根据主键或者唯一索引判断）则先删除此行数据，然后插入新的数据。

     2. 否则，直接插入新数据。

p.s: 插入数据的表必须有主键或者是唯一索引！否则的话，replace into 会直接插入数据，这将导致表中出现重复的数据。



 REPLACE语句会返回一个数，来指示受影响的行的数目。该数是被删除和被插入的行数的和。如果对于一个单行REPLACE该数为1，则一行被插入，同时没有行被删除。如果该数大于1，则在新行被插入前，有一个或多个旧行被删除。如果表包含多个唯一索引，并且新行复制了在不同的唯一索引中的不同旧行的值，则有可能是一个单一行替换了多个旧行。



### 还有两点需要特别注意,否则会很容易出问题:

    1. replace into的时候会删除老记录。如果表中有一个自增的主键。那么就有问题了。首先，因为新纪录与老记录的主键值不同，所以其他表中所有与本表老数据主键id建立的关联全部会被破坏。

    2. 频繁的REPLACE INTO 会造成新纪录的主键的值迅速增大。总有一天。达到最大值后就会因为数据太大溢出了。就没法再插入新纪录了。数据表满了，不是因为空间不够了，而是因为主键的值没法再增加了。




