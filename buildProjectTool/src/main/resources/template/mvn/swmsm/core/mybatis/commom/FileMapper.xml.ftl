<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.common.FileDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.FileDO">
        select `id`,`type`,`url`,`create_date` from sys_file where id = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.FileDO">
        select `id`,`type`,`url`,`create_date` from sys_file
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="type != null and type != ''"> and type = ${r'#'}{type}</if>
            <if test="url != null and url != ''"> and url = ${r'#'}{url}</if>
            <if test="createDate != null and createDate != ''"> and create_date = ${r'#'}{createDate}</if>
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
        select count(*) from sys_file
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="type != null and type != ''"> and type = ${r'#'}{type}</if>
            <if test="url != null and url != ''"> and url = ${r'#'}{url}</if>
            <if test="createDate != null and createDate != ''"> and create_date = ${r'#'}{createDate}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.FileDO" useGeneratedKeys="true"
            keyProperty="id">
        insert into sys_file
        (
        `type`,
        `url`,
        `create_date`
        )
        values
        (
        ${r'#'}{type},
        ${r'#'}{url},
        ${r'#'}{createDate}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.FileDO">
        update sys_file
        <set>
            <if test="type != null">`type` = ${r'#'}{type},</if>
            <if test="url != null">`url` = ${r'#'}{url},</if>
            <if test="createDate != null">`create_date` = ${r'#'}{createDate}</if>
        </set>
        where id = ${r'#'}{id}
    </update>

    <delete id="remove">
        delete from sys_file where id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_file where id in
        <foreach item="id" collection="array" open="(" separator="," close=")">
            ${r'#'}{id}
        </foreach>
    </delete>

</mapper>