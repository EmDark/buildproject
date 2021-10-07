<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.system.MenuDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.MenuDO">
        select
        `menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`gmt_create`,`gmt_modified`
        from sys_menu where menu_id = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.MenuDO">
        select
        `menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`gmt_create`,`gmt_modified`
        from sys_menu
        <where>
            <if test="menuId != null and menuId != ''"> and menu_id = ${r'#'}{menuId}</if>
            <if test="parentId != null and parentId != ''"> and parent_id = ${r'#'}{parentId}</if>
            <if test="name != null and name != ''"> and name = ${r'#'}{name}</if>
            <if test="url != null and url != ''"> and url = ${r'#'}{url}</if>
            <if test="perms != null and perms != ''"> and perms = ${r'#'}{perms}</if>
            <if test="type != null and type != ''"> and type = ${r'#'}{type}</if>
            <if test="icon != null and icon != ''"> and icon = ${r'#'}{icon}</if>
            <if test="orderNum != null and orderNum != ''"> and order_num = ${r'#'}{orderNum}</if>
            <if test="gmtCreate != null and gmtCreate != ''"> and gmt_create = ${r'#'}{gmtCreate}</if>
            <if test="gmtModified != null and gmtModified != ''"> and gmt_modified = ${r'#'}{gmtModified}</if>
        </where>
        <choose>
            <when test="sort != null and sort.trim() != ''">
                order by ${r'$'}{sort} ${r'$'}{order}
            </when>
            <otherwise>
                order by menu_id desc
            </otherwise>
        </choose>
        <if test="offset != null and limit != null">
            limit ${r'#'}{offset}, ${r'#'}{limit}
        </if>
    </select>

    <select id="count" resultType="int">
        select count(*) from sys_menu
        <where>
            <if test="menuId != null and menuId != ''"> and menu_id = ${r'#'}{menuId}</if>
            <if test="parentId != null and parentId != ''"> and parent_id = ${r'#'}{parentId}</if>
            <if test="name != null and name != ''"> and name = ${r'#'}{name}</if>
            <if test="url != null and url != ''"> and url = ${r'#'}{url}</if>
            <if test="perms != null and perms != ''"> and perms = ${r'#'}{perms}</if>
            <if test="type != null and type != ''"> and type = ${r'#'}{type}</if>
            <if test="icon != null and icon != ''"> and icon = ${r'#'}{icon}</if>
            <if test="orderNum != null and orderNum != ''"> and order_num = ${r'#'}{orderNum}</if>
            <if test="gmtCreate != null and gmtCreate != ''"> and gmt_create = ${r'#'}{gmtCreate}</if>
            <if test="gmtModified != null and gmtModified != ''"> and gmt_modified = ${r'#'}{gmtModified}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.MenuDO"
            useGeneratedKeys="true" keyProperty="menuId">
        insert into sys_menu
        (
        `parent_id`,
        `name`,
        `url`,
        `perms`,
        `type`,
        `icon`,
        `order_num`,
        `gmt_create`,
        `gmt_modified`
        )
        values
        (
        ${r'#'}{parentId},
        ${r'#'}{name},
        ${r'#'}{url},
        ${r'#'}{perms},
        ${r'#'}{type},
        ${r'#'}{icon},
        ${r'#'}{orderNum},
        ${r'#'}{gmtCreate},
        ${r'#'}{gmtModified}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.MenuDO">
        update sys_menu
        <set>
            <if test="parentId != null">`parent_id` = ${r'#'}{parentId},</if>
            <if test="name != null">`name` = ${r'#'}{name},</if>
            <if test="url != null">`url` = ${r'#'}{url},</if>
            <if test="perms != null">`perms` = ${r'#'}{perms},</if>
            <if test="type != null">`type` = ${r'#'}{type},</if>
            <if test="icon != null">`icon` = ${r'#'}{icon},</if>
            <if test="orderNum != null">`order_num` = ${r'#'}{orderNum},</if>
            <if test="gmtCreate != null">`gmt_create` = ${r'#'}{gmtCreate},</if>
            <if test="gmtModified != null">`gmt_modified` = ${r'#'}{gmtModified}</if>
        </set>
        where menu_id = ${r'#'}{menuId}
    </update>

    <delete id="remove">
        delete from sys_menu where menu_id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_menu where menu_id in
        <foreach item="menuId" collection="array" open="(" separator=","
                 close=")">
            ${r'#'}{menuId}
        </foreach>
    </delete>

    <select id="listMenuByUserId" resultType="${basePackageName}.${projectName}.core.entity.MenuDO">
        select distinct
        m.menu_id , parent_id, name, url,
        perms,`type`,icon,order_num,gmt_create, gmt_modified
        from sys_menu m
        left
        join sys_role_menu rm on m.menu_id = rm.menu_id left join
        sys_user_role ur
        on rm.role_id =ur.role_id where ur.user_id = ${r'#'}{id}
        and
        m.type in(0,1)
        order by
        m.order_num
    </select>

    <select id="listUserPerms" resultType="string">
        select distinct m.perms
        from sys_menu m left join
        sys_role_menu rm on m.menu_id = rm.menu_id
        left join sys_user_role ur
        on rm.role_id = ur.role_id where ur.user_id
        = ${r'#'}{id}
    </select>
</mapper>