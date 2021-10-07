package ${basePackageName}.${projectName}.admin;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;


/**
* @author huliang
* @date 2021/05/28 12:19
*/
@Slf4j
@EnableTransactionManagement
@ServletComponentScan
@MapperScan(basePackages = {"${basePackageName}.${projectName}.core.dao"})
@SpringBootApplication(scanBasePackages = {"${basePackageName}.${projectName}"},exclude = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
public class ApplicationStarter {

public static void main(String[] args) {
ConfigurableApplicationContext context = SpringApplication.run(ApplicationStarter.class, args);
ConfigurableEnvironment environment = context.getEnvironment();
String serverPort = environment.getProperty("server.port");
log.info("SpringBootAdmin: http://localhost:" + serverPort);
}
}
