<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.system.RoleDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.RoleDO">
        select
        `role_id`,`role_name`,`role_sign`,`remark`,`user_id_create`,`gmt_create`,`gmt_modified`
        from sys_role where role_id = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.RoleDO">
        select
        `role_id`,`role_name`,`role_sign`,`remark`,`user_id_create`,`gmt_create`,`gmt_modified`
        from sys_role
        <where>
            <if test="roleId != null and roleId != ''"> and role_id = ${r'#'}{roleId}</if>
            <if test="roleName != null and roleName != ''"> and role_name = ${r'#'}{roleName}</if>
            <if test="roleSign != null and roleSign != ''"> and role_sign = ${r'#'}{roleSign}</if>
            <if test="remark != null and remark != ''"> and remark = ${r'#'}{remark}</if>
            <if test="userIdCreate != null and userIdCreate != ''"> and user_id_create = ${r'#'}{userIdCreate}</if>
            <if test="gmtCreate != null and gmtCreate != ''"> and gmt_create = ${r'#'}{gmtCreate}</if>
            <if test="gmtModified != null and gmtModified != ''"> and gmt_modified = ${r'#'}{gmtModified}</if>
        </where>
        <choose>
            <when test="sort != null and sort.trim() != ''">
                order by ${r'$'}{sort} ${r'$'}{order}
            </when>
            <otherwise>
                order by role_id desc
            </otherwise>
        </choose>
        <if test="offset != null and limit != null">
            limit ${r'#'}{offset}, ${r'#'}{limit}
        </if>
    </select>

    <select id="count" resultType="int">
        select count(*) from sys_role
        <where>
            <if test="roleId != null and roleId != ''"> and role_id = ${r'#'}{roleId}</if>
            <if test="roleName != null and roleName != ''"> and role_name = ${r'#'}{roleName}</if>
            <if test="roleSign != null and roleSign != ''"> and role_sign = ${r'#'}{roleSign}</if>
            <if test="remark != null and remark != ''"> and remark = ${r'#'}{remark}</if>
            <if test="userIdCreate != null and userIdCreate != ''"> and user_id_create = ${r'#'}{userIdCreate}</if>
            <if test="gmtCreate != null and gmtCreate != ''"> and gmt_create = ${r'#'}{gmtCreate}</if>
            <if test="gmtModified != null and gmtModified != ''"> and gmt_modified = ${r'#'}{gmtModified}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.RoleDO"
            useGeneratedKeys="true" keyProperty="roleId">
        insert into sys_role
        (
        `role_name`,
        `role_sign`,
        `remark`,
        `user_id_create`,
        `gmt_create`,
        `gmt_modified`
        )
        values
        (
        ${r'#'}{roleName},
        ${r'#'}{roleSign},
        ${r'#'}{remark},
        ${r'#'}{userIdCreate},
        ${r'#'}{gmtCreate},
        ${r'#'}{gmtModified}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.RoleDO">
        update sys_role
        <set>
            <if test="roleName != null">`role_name` = ${r'#'}{roleName},</if>
            <if test="roleSign != null">`role_sign` = ${r'#'}{roleSign},</if>
            <if test="remark != null">`remark` = ${r'#'}{remark},</if>
            <if test="userIdCreate != null">`user_id_create` = ${r'#'}{userIdCreate},</if>
            <if test="gmtCreate != null">`gmt_create` = ${r'#'}{gmtCreate},</if>
            <if test="gmtModified != null">`gmt_modified` = ${r'#'}{gmtModified}</if>
        </set>
        where role_id = ${r'#'}{roleId}
    </update>

    <delete id="remove">
        delete from sys_role where role_id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_role where role_id in
        <foreach item="roleId" collection="array" open="(" separator=","
                 close=")">
            ${r'#'}{roleId}
        </foreach>
    </delete>

</mapper>