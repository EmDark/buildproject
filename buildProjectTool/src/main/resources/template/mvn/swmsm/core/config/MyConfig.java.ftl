package ${basePackageName}.${projectName}.core.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
* @author huliang
* @date 2021/06/09 11:48
*/
@Component
@ConfigurationProperties(prefix="myconfig")
public class MyConfig {
//上传路径
private String uploadPath;

private String username;

private String password;

public String getUploadPath() {
return uploadPath;
}

public void setUploadPath(String uploadPath) {
this.uploadPath = uploadPath;
}

public String getUsername() {
return username;
}

public void setUsername(String username) {
this.username = username;
}

public String getPassword() {
return password;
}

public void setPassword(String password) {
this.password = password;
}
}
