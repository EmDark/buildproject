package ${basePackageName}.${projectName}.service.common;


import ${basePackageName}.${projectName}.core.entity.LogDO;
import ${basePackageName}.${projectName}.core.entity.PageDO;
import ${basePackageName}.${projectName}.core.util.Query;
import org.springframework.stereotype.Service;

/**
* @author huliang
*/
@Service
public interface LogService {

void save(LogDO logDO);

PageDO
<LogDO> queryList(Query query);

    int remove(Long id);

    int batchRemove(Long[] ids);
    }
