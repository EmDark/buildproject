package ${basePackageName}.${projectName}.core.dao.common;

import ${basePackageName}.${projectName}.core.entity.LogDO;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

/**
* 系统日志
* @author huliang
* @email 1992lcg@163.com
* @date 2017-10-03 15:45:42
*/
@Mapper
public interface LogDao {

LogDO get(Long id);

List
<LogDO> list(Map
    <String
    , Object> map);

    int count(Map
    <String
    , Object> map);

    int save(LogDO log);

    int update(LogDO log);

    int remove(Long id);

    int batchRemove(Long[] ids);
    }
