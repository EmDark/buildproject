<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.system.RoleMenuDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.RoleMenuDO">
        select `id`,`role_id`,`menu_id` from
        sys_role_menu where id = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.RoleMenuDO">
        select `id`,`role_id`,`menu_id` from sys_role_menu
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="roleId != null and roleId != ''"> and role_id = ${r'#'}{roleId}</if>
            <if test="menuId != null and menuId != ''"> and menu_id = ${r'#'}{menuId}</if>
        </where>
        <choose>
            <when test="sort != null and sort.trim() != ''">
                order by ${r'$'}{sort} ${r'$'}{order}
            </when>
            <otherwise>
                order by id desc
            </otherwise>
        </choose>
        <if test="offset != null and limit != null">
            limit ${r'#'}{offset}, ${r'#'}{limit}
        </if>
    </select>

    <select id="count" resultType="int">
        select count(*) from sys_role_menu
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="roleId != null and roleId != ''"> and role_id = ${r'#'}{roleId}</if>
            <if test="menuId != null and menuId != ''"> and menu_id = ${r'#'}{menuId}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.RoleMenuDO"
            useGeneratedKeys="true" keyProperty="id">
        insert into sys_role_menu
        (
        `role_id`,
        `menu_id`
        )
        values
        (
        ${r'#'}{roleId},
        ${r'#'}{menuId}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.RoleMenuDO">
        update sys_role_menu
        <set>
            <if test="roleId != null">`role_id` = ${r'#'}{roleId},</if>
            <if test="menuId != null">`menu_id` = ${r'#'}{menuId}</if>
        </set>
        where id = ${r'#'}{id}
    </update>

    <delete id="remove">
        delete from sys_role_menu where id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_role_menu where id in
        <foreach item="id" collection="array" open="(" separator=","
                 close=")">
            ${r'#'}{id}
        </foreach>
    </delete>

    <select id="listMenuIdByRoleId" resultType="long">
        select menu_id from sys_role_menu
        <where>role_id = ${r'#'}{roleId}</where>
    </select>

    <delete id="removeByRoleId">
        DELETE FROM sys_role_menu WHERE role_id=${r'#'}{roleId}
    </delete>

    <delete id="removeByMenuId">
        DELETE FROM sys_role_menu WHERE menu_id=${r'#'}{menuId}
    </delete>

    <insert id="batchSave">
        INSERT INTO sys_role_menu(role_id, menu_id) values
        <foreach item="item" index="index" collection="list"
                 separator=",">
            (${r'#'}{item.roleId},${r'#'}{item.menuId})
        </foreach>
    </insert>
</mapper>