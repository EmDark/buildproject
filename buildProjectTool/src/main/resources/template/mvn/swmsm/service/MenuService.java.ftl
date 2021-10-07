package ${basePackageName}.${projectName}.service;

import ${basePackageName}.${projectName}.core.entity.MenuDO;
import ${basePackageName}.${projectName}.core.entity.Tree;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.stereotype.Service;

@Service
public interface MenuService {
Tree
<MenuDO> getSysMenuTree(Long id);

    List
    <Tree
    <MenuDO>> listMenuTree(Long id);

        Tree
        <MenuDO> getTree();

            Tree
            <MenuDO> getTree(Long id);

                List
                <MenuDO> list(Map
                    <String
                    , Object> params);

                    int remove(Long id);

                    int save(MenuDO menu);

                    int update(MenuDO menu);

                    MenuDO get(Long id);

                    Set
                    <String> listPerms(Long userId);
                        }
