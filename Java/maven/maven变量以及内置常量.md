# 1. 变量

在根节点project下增加properties节点，所有自定义变量均可以定义在此节点内

```
<!-- 全局属性配置 -->  
<properties>  
    <project.build.name>tools</project.build.name>  
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>  
</properties>  
```

# 2. 内置变量

* ${basedir} 项目根目录
* ${project.build.directory} 构建目录，缺省为target
* ${project.build.outputDirectory} 构建过程输出目录，缺省为target/classes
* ${project.build.finalName} 产出物名称，缺省为${project.artifactId}-${project.version}
* ${project.packaging} 打包类型，缺省为jar
* ${project.xxx} 当前pom文件的任意节点的内容