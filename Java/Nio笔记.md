Channel

==

![p1][1]



Java NIO: Channels read data into Buffers, and Buffers write data into Channels



##### 四种最重要的实现方式

---

*  FileChannel-----reads data from and to files

* DatagramChannel----can read and write data over the network via UDP

* SocketChannel----can read and write data over the network via TCP

* ServerSocketChannel----allows you to listen for incoming TCP connections, like a web server does. For each incoming connection a SocketChannel is created



Buffer

==

> 一个buffer本质上是一个内存块,只不过这个内存块被包装成一个含有一系列方法的NIO Buffer对象,以便去操作这个内存块



##### 基本用法

---

用buffer去读写数据需遵从以下4个步骤:



1. Write data into the Buffer

2. Call buffer.flip()

3. Read data out of the Buffer

4. Call buffer.clear() or buffer.compact()



```java

RandomAccessFile aFile = new RandomAccessFile("data/nio-data.txt", "rw");

FileChannel inChannel = aFile.getChannel();



//create buffer with capacity of 48 bytes

ByteBuffer buf = ByteBuffer.allocate(48);



int bytesRead = inChannel.read(buf); //read into buffer.

while (bytesRead != -1) {



  buf.flip();  //make buffer ready for read



  while(buf.hasRemaining()){

      System.out.print((char) buf.get()); // read 1 byte at a time

  }



  buf.clear(); //make buffer ready for writing

  bytesRead = inChannel.read(buf);

}

aFile.close();

```

##### Buffer Capacity, Position and Limit

---

![p2][2]

Buffer capacity, position and limit in write and read mode.



* Capacity



  内存块的容量



* Position



1. Write Mode

  

  数据写入的位置,初始值为0.

2. Read Mode

  

  数据读取的位置;调用flip函数会使position重设为0.

  

* limit



1. Write Mode



 等于Buffer的容量,即capacity.

 

2. Read Mode



 当buffer转入读模式,limit的值等于之前写模式是的position的值,即写了多少数据,就只能读多少

 

##### Buffer Types

---

* ByteBuffer

* MappedByteBuffer

* CharBuffer

* DoubleBuffer

* FloatBuffer

* IntBuffer

* LongBuffer

* ShortBuffer



##### Channel to Channel Transfers

---

* transferFrom()



```java

RandomAccessFile fromFile = new RandomAccessFile("fromFile.txt", "rw");

FileChannel      fromChannel = fromFile.getChannel();



RandomAccessFile toFile = new RandomAccessFile("toFile.txt", "rw");

FileChannel      toChannel = toFile.getChannel();



long position = 0;

long count    = fromChannel.size();



toChannel.transferFrom(fromChannel, position, count);

```







* transferTo()



```java

RandomAccessFile fromFile = new RandomAccessFile("fromFile.txt", "rw");

FileChannel      fromChannel = fromFile.getChannel();



RandomAccessFile toFile = new RandomAccessFile("toFile.txt", "rw");

FileChannel      toChannel = toFile.getChannel();



long position = 0;

long count    = fromChannel.size();



fromChannel.transferTo(position, count, toChannel);

```

 

Selector

==

##### Create



```java

Selector selector = Selector.open();

```

##### Registering Channels with the Selector



```java

channel.configureBlocking(false);

SelectionKey key = channel.register(selector, SelectionKey.OP_READ);

```

register函数第二个参数表示channel需要监听的事件类型(1.Connect 2.Accept 3.Read 4.Write)



##### SelectionKey's

channel通过register方法注册selector后,会返回一个SelectionKey类型的对象,该对象包含一下属性



* Interest Set

 

 channel注册时所选择的感兴趣的事件

 

* Ready Set



```java

int readySet = selectionKey.readyOps();

```



* Channel + Selector



```java

Channel  channel  = selectionKey.channel();

Selector selector = selectionKey.selector();    

```

* Attaching Objects



```java

selectionKey.attach(theObject);

Object attachedObj = selectionKey.attachment();

```

* Selecting Channels via a Selector



1. int select()

2. int select(long timeout)

3. int selectNow()



* selectedKeys()



一旦调用select()方法并返回有多少个已经准备好的channel后,就可以调用selectedKeys()来访问这些channel.



```java

Set<SelectionKey> selectedKeys = selector.selectedKeys();



Iterator<SelectionKey> keyIterator = selectedKeys.iterator();



while(keyIterator.hasNext()) {

    

    SelectionKey key = keyIterator.next();



    if(key.isAcceptable()) {

        // a connection was accepted by a ServerSocketChannel.



    } else if (key.isConnectable()) {

        // a connection was established with a remote server.



    } else if (key.isReadable()) {

        // a channel is ready for reading



    } else if (key.isWritable()) {

        // a channel is ready for writing

    }



    keyIterator.remove();

}

```

FileChannel

==



##### Writing Data to a FileChannel



```java

String newData = "New String to write to file..." + System.currentTimeMillis();



ByteBuffer buf = ByteBuffer.allocate(48);

buf.clear();

buf.put(newData.getBytes());



buf.flip();



while(buf.hasRemaining()) {

    channel.write(buf);

}

```



SocketChannel

==

##### Opening a SocketChannel



```java

SocketChannel socketChannel = SocketChannel.open();

socketChannel.connect(new InetSocketAddress("http://jenkov.com", 80));

```

##### Reading from a SocketChannel



```java

ByteBuffer buf = ByteBuffer.allocate(48);



int bytesRead = socketChannel.read(buf);

```



##### Non-blocking Mode



1. connect()



```java

socketChannel.configureBlocking(false);

socketChannel.connect(new InetSocketAddress("http://jenkov.com", 80));



while(! socketChannel.finishConnect() ){

    //wait, or do something else...    

}

```

ServerSocketChannel

==



##### Non-blocking Mode

In non-blocking mode the accept() method returns immediately, and may thus return null, if no incoming connection had arrived. Therefore you will have to check if the returned SocketChannel is null



```java

ServerSocketChannel serverSocketChannel = ServerSocketChannel.open();



serverSocketChannel.socket().bind(new InetSocketAddress(9999));

serverSocketChannel.configureBlocking(false);



while(true){ 

    SocketChannel socketChannel =

            serverSocketChannel.accept();



    if(socketChannel != null){

        //do something with socketChannel...

        }

}

```























[1]:http://tutorials.jenkov.com/images/java-nio/overview-channels-buffers.png

[2]:http://tutorials.jenkov.com/images/java-nio/buffers-modes.png