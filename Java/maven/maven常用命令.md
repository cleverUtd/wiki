### 编译

    mvn compile

    编译测试代码: mvn test-compile



### 运行单元测试

    mvn test



### 清除目标目录中的生成结果

    mvn clean

    如果pom.xml中设置 war，则此命令相当于mvn war:war
    如果pom.xml中设置 jar，则此命令相当于mvn jar:jar



### 打包，根据pom.xml打成war或jar

    mvn package



### 打包但不测试。

     mvn -D maven.test.skip=true package

    mvn package -Dmaven.test.skip=true



### 在本地 Repository 中安装 jar

    mvn install

    