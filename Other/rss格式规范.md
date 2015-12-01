     在一个RSS文档的开头是一个<rss>节点和一个规定的属性version，该属性规定了该文档将以RSS的哪个版本表示。如果该文档以这个规范来表示，那么它的version属性就必须等于2.0。 

     在<rss>节点的下一级是一个独立的<channel>节点，该节点包含关于channel的信息和内容。 


### 必须的频道节点

|元素|描述|范例|
|:--:|:--:|:--:|
|title|频道(channel)名称。它可以告诉别人如何访问你的服务。如果你有一个与你的RSS文件内容一致的HTML网站，你的title元素值应该与你的网站的标题相同。|GoUpstate.com News Headings|
|link|网站url|http://www.goupstate.com/|
|description|关于该频道的描述|The latest news from GoUpstate.com, a Spartanburg Herald-Joural Web Site|


### 可选的频道元素
|元素|描述|范例|
|:--:|:--:|:--:|
|language|使用的语言|en-us|
|copyright|版权声明|Copyright 2002, Spartanburg Herald-Journal|
|managingEditor|内容负责人的Email|geo@herald.com (George Matesky)|
|webMaster|技术人员的Email|betty@herald.com (Betty Guernsey)|
|pubDate|内容的发布时间|Sat, 07 Sep 2002 00:00:01 GMT|
|lastBuildDate|最后更新时间|Sat, 07 Sep 2002 09:42:31 GMT|
|category|指定该频道所属的一个或多个分类。遵循与item级category元素相同的规则。|<category>Newspapers</category>|
|generator|生成该频道的程序名称|MightyInHouse Content System v2.3|
|docs|指向rss格式文档的url地址?|http://blogs.law.harvard.edu/tech/rss|
|cloud|允许所有进程注册一个cloud用于获得频道的更新通知，并为rss种子实现一个轻量级的发布订阅协议。|<cloud domain="rpc.sys.com" port="80" path="/RPC2" registerProcedure="pingMe" protocol="soap"/>|
|ttl|Time to live的缩写。它指示cache的有效保存时间。|<ttl>60</ttl>|
|image|与频道一起显示的图片地址|--|



### <item>子节点

|元素|描述|范例|
|:--:|:--:|:--:|
|title|标题|Venice Film Festival Tries to Quit Sinking|
|link|item的URL|http://www.nytimes.com/2002/09/07/movies/07FEST.html|
|description|概要|Some of the most heated chatter at the Venice Film Festival this week was about the way that the arrival of the stars at the Palazzo del Cinema was being staged.|
|author|作者的email地址|oprah@oxygen.net|
|category|item可以包含在一个或多个分类中|Simpsons Characters|
|comments|与item相关的评论的地址|http://www.myblog.org/cgi-local/mt/mt-comments.cgi?entry_id=290|
|guid|可以唯一确定item的字符串|http://inessential.com/2002/09/01.php#a2|
|pubDate|item发布的时间|Sun, 19 May 2002 15:21:36 GMT|
|source|rss频道来源|Quotes of the Day|

