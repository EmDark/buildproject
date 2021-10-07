<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.common.LogDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.LogDO">
        select `id`,`user_id`,`username`,`operation`,`time`,`method`,`params`,`ip`,`gmt_create` from sys_log where id
        = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.LogDO">
        select `id`,`user_id`,`username`,`operation`,`time`,`method`,`params`,`ip`,`gmt_create` from sys_log
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="userId != null and userId != ''"> and user_id = ${r'#'}{userId}</if>
            <if test="username != null and username != ''"> and username = ${r'#'}{username}</if>
            <if test="operation != null and operation != ''"> and operation = ${r'#'}{operation}</if>
            <if test="time != null and time != ''"> and time = ${r'#'}{time}</if>
            <if test="method != null and method != ''"> and method = ${r'#'}{method}</if>
            <if test="params != null and params != ''"> and params = ${r'#'}{params}</if>
            <if test="ip != null and ip != ''"> and ip = ${r'#'}{ip}</if>
            <if test="gmtCreate != null and gmtCreate != ''"> and gmt_create = ${r'#'}{gmtCreate}</if>
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
        select count(*) from sys_log
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="userId != null and userId != ''"> and user_id = ${r'#'}{userId}</if>
            <if test="username != null and username != ''"> and username = ${r'#'}{username}</if>
            <if test="operation != null and operation != ''"> and operation = ${r'#'}{operation}</if>
            <if test="time != null and time != ''"> and time = ${r'#'}{time}</if>
            <if test="method != null and method != ''"> and method = ${r'#'}{method}</if>
            <if test="params != null and params != ''"> and params = ${r'#'}{params}</if>
            <if test="ip != null and ip != ''"> and ip = ${r'#'}{ip}</if>
            <if test="gmtCreate != null and gmtCreate != ''"> and gmt_create = ${r'#'}{gmtCreate}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.LogDO" useGeneratedKeys="true"
            keyProperty="id">
        insert into sys_log
        (
        `user_id`,
        `username`,
        `operation`,
        `time`,
        `method`,
        `params`,
        `ip`,
        `gmt_create`
        )
        values
        (
        ${r'#'}{userId},
        ${r'#'}{username},
        ${r'#'}{operation},
        ${r'#'}{time},
        ${r'#'}{method},
        ${r'#'}{params},
        ${r'#'}{ip},
        ${r'#'}{gmtCreate}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.LogDO">
        update sys_log
        <set>
            <if test="userId != null">`user_id` = ${r'#'}{userId},</if>
            <if test="username != null">`username` = ${r'#'}{username},</if>
            <if test="operation != null">`operation` = ${r'#'}{operation},</if>
            <if test="time != null">`time` = ${r'#'}{time},</if>
            <if test="method != null">`method` = ${r'#'}{method},</if>
            <if test="params != null">`params` = ${r'#'}{params},</if>
            <if test="ip != null">`ip` = ${r'#'}{ip},</if>
            <if test="gmtCreate != null">`gmt_create` = ${r'#'}{gmtCreate}</if>
        </set>
        where id = ${r'#'}{id}
    </update>

    <delete id="remove">
        delete from sys_log where id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_log where id in
        <foreach item="id" collection="array" open="(" separator="," close=")">
            ${r'#'}{id}
        </foreach>
    </delete>

</mapper>