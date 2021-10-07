package ${basePackageName}.${projectName}.service;

import ${basePackageName}.${projectName}.core.entity.DeptDO;
import ${basePackageName}.${projectName}.core.entity.Tree;
import java.util.List;
import java.util.Map;

/**
* 部门管理
*
* @author huliang
* @email 1992lcg@163.com
* @date 2017-09-27 14:28:36
*/
public interface DeptService {

DeptDO get(Long deptId);

List
<DeptDO> list(Map
    <String
    , Object> map);

    int count(Map
    <String
    , Object> map);

    int save(DeptDO sysDept);

    int update(DeptDO sysDept);

    int remove(Long deptId);

    int batchRemove(Long[] deptIds);

    Tree
    <DeptDO> getTree();

        boolean checkDeptHasUser(Long deptId);

        List
        <Long> listChildrenIds(Long parentId);
            }
