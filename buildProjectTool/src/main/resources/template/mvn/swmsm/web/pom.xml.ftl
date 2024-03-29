<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">

    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>${basePackageName}.${projectName}</groupId>
        <artifactId>${projectName}-parent</artifactId>
        <version>1.0.0-SNAPSHOT</version>
    </parent>
    <artifactId>${projectName}-web</artifactId>
    <packaging>jar</packaging>
    <name>${r"$"}{project.artifactId} v${r"$"}{project.version}</name>
    <properties>
        <start-class>${basePackageName}.${projectName}.web.ApplicationStarter</start-class>
    </properties>
    <dependencies>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
        </dependency>
    </dependencies>
</project>
