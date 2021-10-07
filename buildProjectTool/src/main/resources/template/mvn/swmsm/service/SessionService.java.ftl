package ${basePackageName}.${projectName}.service;

import ${basePackageName}.${projectName}.core.entity.UserDO;
import ${basePackageName}.${projectName}.core.entity.UserOnline;
import java.util.Collection;
import java.util.List;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Service;

@Service
public interface SessionService {
List
<UserOnline> list();

    List
    <UserDO> listOnlineUser();

        Collection
        <Session> sessionList();

            boolean forceLogout(String sessionId);
            }
