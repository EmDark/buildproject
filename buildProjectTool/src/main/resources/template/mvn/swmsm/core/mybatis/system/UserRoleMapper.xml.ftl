<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.system.UserRoleDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.UserRoleDO">
        select `id`,`user_id`,`role_id` from
        sys_user_role where id = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.UserRoleDO">
        select `id`,`user_id`,`role_id` from sys_user_role
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="userId != null and userId != ''"> and user_id = ${r'#'}{userId}</if>
            <if test="roleId != null and roleId != ''"> and role_id = ${r'#'}{roleId}</if>
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
        select count(*) from sys_user_role
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="userId != null and userId != ''"> and user_id = ${r'#'}{userId}</if>
            <if test="roleId != null and roleId != ''"> and role_id = ${r'#'}{roleId}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.UserRoleDO"
            useGeneratedKeys="true" keyProperty="id">
        insert into sys_user_role
        (
        `user_id`,
        `role_id`
        )
        values
        (
        ${r'#'}{userId},
        ${r'#'}{roleId}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.UserRoleDO">
        update sys_user_role
        <set>
            <if test="userId != null">`user_id` = ${r'#'}{userId},</if>
            <if test="roleId != null">`role_id` = ${r'#'}{roleId}</if>
        </set>
        where id = ${r'#'}{id}
    </update>

    <delete id="remove">
        delete from sys_user_role where id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_user_role where id in
        <foreach item="id" collection="array" open="(" separator=","
                 close=")">
            ${r'#'}{id}
        </foreach>
    </delete>

    <select id="listRoleId" resultType="long">
        select role_id from
        sys_user_role where
        user_id=${r'#'}{userId}
    </select>

    <delete id="removeByUserId">
        delete from sys_user_role where user_id=${r'#'}{userId}
    </delete>

    <delete id="removeByRoleId">
        delete from sys_user_role where role_id=${r'#'}{roleId}
    </delete>

    <delete id="batchRemoveByUserId">
        delete from sys_user_role where user_id in
        <foreach item="id" collection="array" open="(" separator=","
                 close=")">
            ${r'#'}{id}
        </foreach>
    </delete>

    <insert id="batchSave">
        INSERT INTO sys_user_role(user_id, role_id) values
        <foreach item="item" index="index" collection="list"
                 separator=",">
            (${r'#'}{item.userId},${r'#'}{item.roleId})
        </foreach>
    </insert>
</mapper>