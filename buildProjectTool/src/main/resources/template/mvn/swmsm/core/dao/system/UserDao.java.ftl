package ${basePackageName}.${projectName}.core.dao.system;

import ${basePackageName}.${projectName}.core.entity.UserDO;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

/**
*
* @author huliang
* @email 1992lcg@163.com
* @date 2017-10-03 09:45:11
*/
@Mapper
public interface UserDao {

UserDO get(Long userId);

List
<UserDO> list(Map
    <String
    , Object> map);

    int count(Map
    <String
    , Object> map);

    int save(UserDO user);

    int update(UserDO user);

    int remove(Long userId);

    int batchRemove(Long[] userIds);

    Long[] listAllDept();

    }
