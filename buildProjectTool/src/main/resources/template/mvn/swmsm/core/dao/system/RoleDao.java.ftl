package ${basePackageName}.${projectName}.core.dao.system;

import ${basePackageName}.${projectName}.core.entity.RoleDO;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

/**
* 角色
* @author huliang
* @email 1992lcg@163.com
* @date 2017-10-02 20:24:47
*/
@Mapper
public interface RoleDao {

RoleDO get(Long roleId);

List
<RoleDO> list(Map
    <String
    , Object> map);

    int count(Map
    <String
    , Object> map);

    int save(RoleDO role);

    int update(RoleDO role);

    int remove(Long roleId);

    int batchRemove(Long[] roleIds);
    }
