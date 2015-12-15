1. 诞生
==

贝尔实验室1977年搞出来的强大文本分析神器
名字取自 三位创始人 Alfred Aho，Peter Weinberger, 和 Brian Kernighan 的Family Name的首字符

2. 结构
==

```
pattern {actions}
```

pattern: 模式, 与正则表达式类似；作为条件，判断是否满足

actions: 执行动作， 若pattern满足，则执行actions。一个pattern对应的actions必须放进 `{}` 内。

示例：
```
    awk '$0>1 {print "hello world"}'
```

注意命令行中的程序是用单引号包围着的，这回防止shell解析程序中 `$` 这样的符号。

3. 简单输出
==

awk程序一次从输入文件中读取一行内容并把它分割成一个个字段, 通常默认情况下, 一个字段是一个不包含任何空格或制表符的连续字符. 当前输入行中的第一个字段被称做 $1, 第二个是 $2, 以此类推. 整个行的内容被定义为 $0. 每一行的字段数量可以不同

##### 3.1 打印每一行

```
{ print } 或者 { print $0 }
```

##### 3.2 打印特定字段

```
{ print $1, $3 }
```

##### 3.3 NF, 字段数量

Awk会对当前输入的行有多少个字段进行计数, 并且将当前行的字段数量存储在一个内建的称作 NF 的变量中
```
{ print NF, $1, $NF }
```
会依次打印出每一行的字段数量, 第一个字段的值, 最后一个字段的值.

##### 3.4 计算和打印

可以对字段的值进行计算后再打印出来
```
{ print $1, $2 * $3 }
```

##### 3.5 打印行号

内建变量 NR，存储当前已经读取了多少行的计数
```
{ print NR, $0 }
```

4. 高级输出
==

##### 4.1 printf

和c语言的printf输出类似
```
printf(format, value1, value2, ..., valuen)
```
先定义每个值的输出规格，然后在输出值。有多少 value 要打印，在 format 中就要有多少个 % 规格

示例
```
{ printf("total pay for %s is $%.2f\n", $1, $2 * $3) } 
{ printf("%-8s $%6.2f\n", $1, $2 * $3) }
```


##### 4.2 排序输出

```
awk '{ printf("%6.2f   %s\n", $2 * $3, $0) }' file | sort
```

将awk的输出通过管道传给 linux的 sort 命令

5. 选择
==

不带动作的模式会打印所有匹配模式的行，所以很多awk程序仅包含一个模式

##### 5.1 对比选择

输出第二个字段大于等于5的行
```
$2 >= 5
```

##### 5.2 计算选择

打印第二和第三个字段的乘积大于等于50的行
```
awk '$2*$3>=50'
```

##### 5.3 文本选择

打印
```
$1 == "Susie"
```

##### 5.4 模式组合

可以使用括号和逻辑操作符与 && ， 或 || ， 以及非 ! 对模式进行组合

```
$2 >= 4 || $3 >= 20
```

6. 计算
==
新建文件 emp.data

|员工名称|时薪|工作时长|
|:---:|:---:|:---:|
|Beth|4.00|0|
|Dan|3.75|0|
|wqkathy|4.00|10|
|Mark|5.00|20|
|Mary|5.50|22|
|Susie|4.25|18|

##### 6.1 计数

使用一个变量 emp 来统计工作超过15个小时的员工的数目
```
$3 > 15 { emp = emp + 1 }
END     { print emp, "employees worked more than 15 hours" }
```
用作数字的awk变量的默认初始值为0，所以我们不需要初始化 emp 。


##### 6.2 求和与平均值

计算员工的数目，我们可以使用内置变量 NR ，它保存着到目前位置读取的行数；在所有输入的结尾它的值就是所读的所有行数。
```
END { print NR, "employees" }
```

使用 NR 来计算薪酬均值的程序
```
 { pay = pay + $2 * $3 }
END { print NR, "employees"
      print "total pay is", pay
      print "average pay is", pay/NR
    }
```


##### 6.3 处理文本

找出时薪最高的员工

```
$2 > maxrate { maxrate = $2; maxemp = $1 }
END { print "highest hourly rate:", maxrate, "for", maxemp }
```
变量 maxrate 保存着一个数值，而变量 maxemp 则是保存着一个字符串。（如果有几个员工都有着相同的最大时薪，该程序则只找出第一个


##### 6.4 字符串连接

```
{ names = names $1 " "}
END { print names }
```
通过将每个姓名和一个空格附加到变量 names 的前一个值， 来将所有员工的姓名收集进单个字符串中。最后 END 动作打印出 names 的值

##### 6.5 计算一个字符串的字符数量

使用awk内置函数`length`
```
{ print $1, length($1) }
```

##### 6.6 行、单词以及字符的计数

使用了 length、NF、以及 NR 来统计输入中行、单词以及字符的数量。为了简便，每个字段看作一个单词
```
{ nc = nc + length($0) + 1
      nw = nw + NF
    }
END { print NR, "lines,", nw, "words,", nc, "characters" }
```

ps：$0 并不包含每个输入行的末尾的换行符，所以我们要另外加个1。

7. 控制语句
==

Awk提供一个 if-else 语句，以及为循环提供了几个语句，所以都效仿C语言中对应的控制语句。它们仅可以在动作中使用。

##### 7.1 if-else语句
计算时薪超过6美元的员工的总薪酬与平均薪酬。它使用一个 if 来防范计算平均薪酬时的零除问题。
```
$2 > 6 { n = n + 1; pay = pay + $2 * $3 }
END    { if (n > 0)
            print n, "employees, total pay is", pay,
                     "average pay is", pay/n
         else
             print "no employees are paid more than $6/hour"
        }
```
if-else 语句中，if 后的条件会被计算。如果为真，执行第一个 print 语句。否则，执行第二个 print 语句。注意我们可以使用一个逗号将一个长语句截断为多行来书写。

##### 7.2 while语句

一个 while 语句有一个条件和一个执行体。条件为真时执行体中的语句会被重复执行。这个程序使用公式 value=amount(1+rate)^years
来演示以特定的利率投资一定量的钱，其数值是如何随着年数增长的。

```
## 输入: 钱数    利率    年数
#   输出: 复利值

{   i = 1
    while (i <= $3) {
        printf("\t%.2f\n", $1 * (1 + $2) ^ i)
        i = i + 1
    }
}
```


##### 7.3 for语句

依然是计算利息的例子

```
# interest1 - 计算复利
#   输入: 钱数    利率    年数
#   输出: 每年末的复利

{ for (i = 1; i <= $3; i = i + 1)
    printf("\t%.2f\n", $1 * (1 + $2) ^ i)
}
```

8. 数组
==

第一个动作将输入行存为数组 line 的连续元素；即第一行放在 line[1] ，第二行放在 line[2] , 依次继续。 END 动作使用一个 while 语句从后往前打印数组中的输入行

```
# 反转 - 按行逆序打印输入

    { line[NR] = $0 }  # 记下每个输入行

END { i = NR           # 逆序打印
      while (i > 0) {
        print line[i]
        i = i - 1
      }
    }
```

使用 for 语句实现的相同示例
```
# 反转 - 按行逆序打印输入

    { line[NR] = $0 }   # 记下每个输入行

END { for (i = NR; i > 0; i = i - 1)
        print line[i]
    }
```

