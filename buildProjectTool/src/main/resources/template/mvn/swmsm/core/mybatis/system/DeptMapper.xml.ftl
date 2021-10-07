<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.system.DeptDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.DeptDO">
        select
        `dept_id`,`parent_id`,`name`,`order_num`,`del_flag` from sys_dept
        where dept_id = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.DeptDO">
        select `dept_id`,`parent_id`,`name`,`order_num`,`del_flag` from
        sys_dept
        <where>
            <if test="deptId != null and deptId != ''"> and dept_id = ${r'#'}{deptId}</if>
            <if test="parentId != null and parentId != ''"> and parent_id = ${r'#'}{parentId}</if>
            <if test="name != null and name != ''"> and name = ${r'#'}{name}</if>
            <if test="orderNum != null and orderNum != ''"> and order_num = ${r'#'}{orderNum}</if>
            <if test="delFlag != null and delFlag != ''"> and del_flag = ${r'#'}{delFlag}</if>
        </where>
        <choose>
            <when test="sort != null and sort.trim() != ''">
                order by ${r'$'}{sort} ${r'$'}{order}
            </when>
            <otherwise>
                order by dept_id desc
            </otherwise>
        </choose>
        <if test="offset != null and limit != null">
            limit ${r'#'}{offset}, ${r'#'}{limit}
        </if>
    </select>

    <select id="count" resultType="int">
        select count(*) from sys_dept
        <where>
            <if test="deptId != null and deptId != ''"> and dept_id = ${r'#'}{deptId}</if>
            <if test="parentId != null and parentId != ''"> and parent_id = ${r'#'}{parentId}</if>
            <if test="name != null and name != ''"> and name = ${r'#'}{name}</if>
            <if test="orderNum != null and orderNum != ''"> and order_num = ${r'#'}{orderNum}</if>
            <if test="delFlag != null and delFlag != ''"> and del_flag = ${r'#'}{delFlag}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.DeptDO"
            useGeneratedKeys="true" keyProperty="deptId">
        insert into sys_dept
        (
        `parent_id`,
        `name`,
        `order_num`,
        `del_flag`
        )
        values
        (
        ${r'#'}{parentId},
        ${r'#'}{name},
        ${r'#'}{orderNum},
        ${r'#'}{delFlag}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.DeptDO">
        update sys_dept
        <set>
            <if test="parentId != null">`parent_id` = ${r'#'}{parentId},</if>
            <if test="name != null">`name` = ${r'#'}{name},</if>
            <if test="orderNum != null">`order_num` = ${r'#'}{orderNum},</if>
            <if test="delFlag != null">`del_flag` = ${r'#'}{delFlag}</if>
        </set>
        where dept_id = ${r'#'}{deptId}
    </update>

    <delete id="remove">
        delete from sys_dept where dept_id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_dept where dept_id in
        <foreach item="deptId" collection="array" open="(" separator=","
                 close=")">
            ${r'#'}{deptId}
        </foreach>
    </delete>

    <select id="listParentDept" resultType="long">
        select DISTINCT parent_id from sys_dept
    </select>

    <select id="getDeptUserNumber" resultType="int">
        select count(*) from sys_user where dept_id = ${r'#'}{value}
    </select>
</mapper>