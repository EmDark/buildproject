package ${basePackageName}.${projectName}.admin.common.config;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import java.sql.SQLException;
import javax.sql.DataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

/**
* Created by PrimaryKey on 17/2/4.
*/
@SuppressWarnings("AlibabaRemoveCommentedCode")
@Configuration
public class DruidDBConfig {
private Logger logger = LoggerFactory.getLogger(DruidDBConfig.class);
@Value("${r'$'}{spring.datasource.url}")
private String dbUrl;

@Value("${r'$'}{spring.datasource.username}")
private String username;

@Value("${r'$'}{spring.datasource.password}")
private String password;

@Value("${r'$'}{spring.datasource.driverClassName}")
private String driverClassName;

@Value("${r'$'}{spring.datasource.initialSize}")
private int initialSize;

@Value("${r'$'}{spring.datasource.minIdle}")
private int minIdle;

@Value("${r'$'}{spring.datasource.maxActive}")
private int maxActive;

@Value("${r'$'}{spring.datasource.maxWait}")
private int maxWait;

@Value("${r'$'}{spring.datasource.timeBetweenEvictionRunsMillis}")
private int timeBetweenEvictionRunsMillis;

@Value("${r'$'}{spring.datasource.minEvictableIdleTimeMillis}")
private int minEvictableIdleTimeMillis;

@Value("${r'$'}{spring.datasource.validationQuery}")
private String validationQuery;

@Value("${r'$'}{spring.datasource.testWhileIdle}")
private boolean testWhileIdle;

@Value("${r'$'}{spring.datasource.testOnBorrow}")
private boolean testOnBorrow;

@Value("${r'$'}{spring.datasource.testOnReturn}")
private boolean testOnReturn;

@Value("${r'$'}{spring.datasource.poolPreparedStatements}")
private boolean poolPreparedStatements;

@Value("${r'$'}{spring.datasource.maxPoolPreparedStatementPerConnectionSize}")
private int maxPoolPreparedStatementPerConnectionSize;

@Value("${r'$'}{spring.datasource.filters}")
private String filters;

@Value("{spring.datasource.connectionProperties}")
private String connectionProperties;

@Bean(initMethod = "init", destroyMethod = "close")   //声明其为Bean实例
@Primary  //在同样的DataSource中，首先使用被标注的DataSource
public DataSource dataSource() {
DruidDataSource datasource = new DruidDataSource();

datasource.setUrl(this.dbUrl);
datasource.setUsername(username);
datasource.setPassword(password);
datasource.setDriverClassName(driverClassName);

//configuration
datasource.setInitialSize(initialSize);
datasource.setMinIdle(minIdle);
datasource.setMaxActive(maxActive);
datasource.setMaxWait(maxWait);
datasource.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);
datasource.setMinEvictableIdleTimeMillis(minEvictableIdleTimeMillis);
datasource.setValidationQuery(validationQuery);
datasource.setTestWhileIdle(testWhileIdle);
datasource.setTestOnBorrow(testOnBorrow);
datasource.setTestOnReturn(testOnReturn);
datasource.setPoolPreparedStatements(poolPreparedStatements);
datasource.setMaxPoolPreparedStatementPerConnectionSize(maxPoolPreparedStatementPerConnectionSize);
try {
datasource.setFilters(filters);
} catch (SQLException e) {
logger.error("druid configuration initialization filter", e);
}
datasource.setConnectionProperties(connectionProperties);

return datasource;
}

@Bean
public ServletRegistrationBean druidServlet() {
ServletRegistrationBean reg = new ServletRegistrationBean();
reg.setServlet(new StatViewServlet());
reg.addUrlMappings("/druid/*");
reg.addInitParameter("allow", ""); //白名单
return reg;
}

@Bean public FilterRegistrationBean filterRegistrationBean() {
FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
filterRegistrationBean.setFilter(new WebStatFilter());
filterRegistrationBean.addUrlPatterns("/*");
filterRegistrationBean.addInitParameter("exclusions", "*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*");
filterRegistrationBean.addInitParameter("profileEnable", "true");
filterRegistrationBean.addInitParameter("principalCookieName","USER_COOKIE");
filterRegistrationBean.addInitParameter("principalSessionName","USER_SESSION");
filterRegistrationBean.addInitParameter("DruidWebStatFilter","/*");
return filterRegistrationBean;
}
}

