package ${basePackageName}.${projectName}.admin.controller;

import ${basePackageName}.${projectName}.core.entity.UserOnline;
import ${basePackageName}.${projectName}.core.util.R;
import ${basePackageName}.${projectName}.service.SessionService;
import java.util.Collection;
import java.util.List;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@RequestMapping("/sys/online")
@Controller
public class SessionController {
@Autowired
SessionService sessionService;

@GetMapping()
public String online() {
return "system/online/online";
}

@ResponseBody
@RequestMapping("/list")
public List
<UserOnline> list() {
    return sessionService.list();
    }

    @ResponseBody
    @RequestMapping("/forceLogout/{sessionId}")
    public R forceLogout(@PathVariable("sessionId") String sessionId, RedirectAttributes redirectAttributes) {
    try {
    sessionService.forceLogout(sessionId);
    return R.ok();
    } catch (Exception e) {
    e.printStackTrace();
    return R.error();
    }

    }

    @ResponseBody
    @RequestMapping("/sessionList")
    public Collection
    <Session> sessionList() {
        return sessionService.sessionList();
        }


        }
