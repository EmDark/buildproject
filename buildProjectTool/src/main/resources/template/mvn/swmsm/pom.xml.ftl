<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">

    <modelVersion>4.0.0</modelVersion>


    <groupId>${basePackageName}.${projectName}</groupId>
    <artifactId>${projectName}-parent</artifactId>
    <packaging>pom</packaging>
    <version>1.0.0-SNAPSHOT</version>
    <name>${r"$"}{project.artifactId} v${r"$"}{project.version}</name>

    <modules>
        <!-- 开放接口层：可直接封装Service方法暴露成RPC接口；通过Web封装成http接口；进行网关安全控制、流量控制 -->
        <module>${projectName}-api</module>
        <!-- 主要是对访问控制进行转发，各类基本参数校验，或者不复用的业务简单处理 -->
        <module>${projectName}-web</module>
        <!-- 相对具体的业务逻辑服务层 -->
        <module>${projectName}-service</module>
        <!-- 通用业务处理层 对第三方平台封装的层，预处理返回结果及转化异常信息 与DAO层交互，对多个DAO的组合复
        外部接口或第三方平台：包括其它部门RPC开放接口，基础平台，其它公司的HTTP接口。
         对Service层通用能力的下沉，如缓存方案、中间件通用处理-->
        <module>${projectName}-manager</module>
        <!-- 数据访问层，与底层MySQL、Oracle、Hbase等进行数据交互 -->
        <module>${projectName}-core</module>
        <!-- 后台管理层 -->
        <module>${projectName}-admin</module>
    </modules>

    <properties>
        <project.version>1.0.0-SNAPSHOT</project.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <spring.version>5.1.5.RELEASE</spring.version>
        <spring.boot.version>2.1.3.RELEASE</spring.boot.version>
    </properties>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.7.0</version>
                <configuration>
                    <source>
                    1.8</source>
                    <target>1.8</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-source-plugin</artifactId>
                <version>3.0.1</version>
                <executions>
                    <execution>
                        <id>attach-sources</id>
                        <goals>
                            <goal>jar</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>

        </plugins>
    </build>

    <dependencyManagement>
        <dependencies>


            <!-- ======= -->
            <!-- 模块依赖 -->
            <!-- ======= -->
            <dependency>
                <groupId>${r"$"}{project.groupId}</groupId>
                <artifactId>${projectName}-api</artifactId>
                <version>${r'${project.version}'}</version>
            </dependency>

            <dependency>
                <groupId>${r"$"}{project.groupId}</groupId>
                <artifactId>${projectName}-core</artifactId>
                <version>${r'${project.version}'}</version>
            </dependency>

            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-framework-bom</artifactId>
                <version>${r'${spring.version}'}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>

            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-context-support</artifactId>
                <version>${r'${spring.version}'}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-devtools</artifactId>
                <version>${r'${spring.version}'}</version>
                <scope>runtime</scope>
            </dependency>


            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>${r'$'}{spring.boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>

            <!-- ======= -->
            <!-- 单元测试 -->
            <!-- ======= -->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-test</artifactId>
                <scope>test</scope>
                <exclusions>
                    <exclusion>
                        <groupId>org.springframework.boot</groupId>
                        <artifactId>spring-boot-starter-logging</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>

            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>4.1</version>
                <scope>test</scope>
            </dependency>

            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-test</artifactId>
                <scope>test</scope>
            </dependency>

            <dependency>
                <groupId>org.powermock</groupId>
                <artifactId>powermock-module-junit4</artifactId>
                <version>2.0.9</version>
                <scope>test</scope>
            </dependency>

            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-test-autoconfigure</artifactId>
                <scope>test</scope>
            </dependency>

            <dependency>
                <groupId>org.mockito</groupId>
                <artifactId>mockito-core</artifactId>
                <scope>test</scope>
            </dependency>

            <dependency>
                <groupId>commons-beanutils</groupId>
                <artifactId>commons-beanutils</artifactId>
                <version>1.9.4</version>
            </dependency>

            <dependency>
                <groupId>org.powermock</groupId>
                <artifactId>powermock-api-mockito2</artifactId>
                <version>2.0.9</version>
                <scope>test</scope>
            </dependency>

            <!-- mybatis-->
            <dependency>
                <groupId>org.mybatis</groupId>
                <artifactId>mybatis</artifactId>
                <version>3.5.4</version>
            </dependency>
            <dependency>
                <groupId>org.mybatis.spring.boot</groupId>
                <artifactId>mybatis-spring-boot-starter</artifactId>
                <version>2.1.2</version>
            </dependency>
            <dependency>
                <groupId>org.mybatis</groupId>
                <artifactId>mybatis-spring</artifactId>
                <version>2.0.4</version>
            </dependency>

            <dependency>
                <groupId>com.baomidou</groupId>
                <artifactId>mybatis-plus-boot-starter</artifactId>
                <version>3.3.2</version>
            </dependency>

            <dependency>
                <groupId>com.baomidou</groupId>
                <artifactId>mybatis-plus-generator</artifactId>
                <version>3.3.2</version>
            </dependency>

            <!--lombok-->
            <dependency>
                <groupId>org.projectlombok</groupId>
                <artifactId>lombok</artifactId>
                <version>1.16.8</version>
            </dependency>
            <!--文档-->
            <dependency>
                <groupId>io.swagger</groupId>
                <artifactId>swagger-annotations</artifactId>
                <version>1.5.22</version>
            </dependency>

            <dependency>
                <groupId>io.springfox</groupId>
                <artifactId>springfox-swagger2</artifactId>
                <version>2.9.2</version>
            </dependency>

            <dependency>
                <groupId>io.springfox</groupId>
                <artifactId>springfox-swagger-ui</artifactId>
                <version>2.9.2</version>
            </dependency>
            <!-- json-->
            <dependency>
                <groupId>com.fasterxml.jackson.core</groupId>
                <artifactId>jackson-core</artifactId>
                <version>2.9.5</version>
            </dependency>
            <!-- 数据库-->


            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>druid</artifactId>
                <version>1.1.22</version>
            </dependency>

            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>druid-spring-boot-starter</artifactId>
                <version>1.2.6</version>
            </dependency>

            <dependency>
                <groupId>com.google.guava</groupId>
                <artifactId>guava</artifactId>
                <version>20.0</version>
                <scope>compile</scope>
            </dependency>
            <dependency>
                <groupId>commons-io</groupId>
                <artifactId>commons-io</artifactId>
                <version>2.4</version>
            </dependency>
            <!-- 二级缓存相关 -->
            <dependency>
                <groupId>com.github.ben-manes.caffeine</groupId>
                <artifactId>caffeine</artifactId>
                <version>2.8.5</version>
            </dependency>

            <dependency>
                <groupId>org.redisson</groupId>
                <artifactId>redisson</artifactId>
                <version>3.6.0</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-messaging</artifactId>
            </dependency>

            <!--日期处理-->
            <dependency>
                <groupId>joda-time</groupId>
                <artifactId>joda-time</artifactId>
                <version>2.9.2</version>
            </dependency>

            <!--http工具包-->
            <dependency>
                <groupId>com.squareup.okhttp3</groupId>
                <artifactId>okhttp</artifactId>
                <version>3.11.0</version>

                <exclusions>
                    <exclusion>
                        <groupId>com.google.android</groupId>
                        <artifactId>android</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>

            <dependency>
                <groupId>org.springframework.security.oauth</groupId>
                <artifactId>spring-security-oauth2</artifactId>
                <version>2.5.1.RELEASE</version>
            </dependency>

        </dependencies>
    </dependencyManagement>
</project>
