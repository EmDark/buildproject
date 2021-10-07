package ${basePackageName}.${projectName}.admin.controller.common;

import ${basePackageName}.${projectName}.admin.common.utils.ShiroUtils;
import ${basePackageName}.${projectName}.core.entity.UserDO;
import org.springframework.stereotype.Controller;

@Controller
public class BaseController {
public UserDO getUser() {
return ShiroUtils.getUser();
}

public Long getUserId() {
return getUser().getUserId();
}

public String getUsername() {
return getUser().getUsername();
}
}