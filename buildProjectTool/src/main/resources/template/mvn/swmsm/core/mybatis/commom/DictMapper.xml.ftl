<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.common.DictDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.DictDO">
        select
        `id`,`name`,`value`,`type`,`description`,`sort`,`parent_id`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`
        from sys_dict where id = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.DictDO">
        select
        `id`,`name`,`value`,`type`,`description`,`sort`,`parent_id`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`
        from sys_dict
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="name != null and name != ''"> and name = ${r'#'}{name}</if>
            <if test="value != null and value != ''"> and value = ${r'#'}{value}</if>
            <if test="type != null and type != ''"> and type = ${r'#'}{type}</if>
            <if test="description != null and description != ''"> and description = ${r'#'}{description}</if>
            <if test="sort != null and sort != ''"> and sort = ${r'#'}{sort}</if>
            <if test="parentId != null and parentId != ''"> and parent_id = ${r'#'}{parentId}</if>
            <if test="createBy != null and createBy != ''"> and create_by = ${r'#'}{createBy}</if>
            <if test="createDate != null and createDate != ''"> and create_date = ${r'#'}{createDate}</if>
            <if test="updateBy != null and updateBy != ''"> and update_by = ${r'#'}{updateBy}</if>
            <if test="updateDate != null and updateDate != ''"> and update_date = ${r'#'}{updateDate}</if>
            <if test="remarks != null and remarks != ''"> and remarks = ${r'#'}{remarks}</if>
            <if test="delFlag != null and delFlag != ''"> and del_flag = ${r'#'}{delFlag}</if>
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
        select count(*) from sys_dict
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="name != null and name != ''"> and name = ${r'#'}{name}</if>
            <if test="value != null and value != ''"> and value = ${r'#'}{value}</if>
            <if test="type != null and type != ''"> and type = ${r'#'}{type}</if>
            <if test="description != null and description != ''"> and description = ${r'#'}{description}</if>
            <if test="sort != null and sort != ''"> and sort = ${r'#'}{sort}</if>
            <if test="parentId != null and parentId != ''"> and parent_id = ${r'#'}{parentId}</if>
            <if test="createBy != null and createBy != ''"> and create_by = ${r'#'}{createBy}</if>
            <if test="createDate != null and createDate != ''"> and create_date = ${r'#'}{createDate}</if>
            <if test="updateBy != null and updateBy != ''"> and update_by = ${r'#'}{updateBy}</if>
            <if test="updateDate != null and updateDate != ''"> and update_date = ${r'#'}{updateDate}</if>
            <if test="remarks != null and remarks != ''"> and remarks = ${r'#'}{remarks}</if>
            <if test="delFlag != null and delFlag != ''"> and del_flag = ${r'#'}{delFlag}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.DictDO"
            useGeneratedKeys="true" keyProperty="id">
        insert into sys_dict
        (
        `name`,
        `value`,
        `type`,
        `description`,
        `sort`,
        `parent_id`,
        `create_by`,
        `create_date`,
        `update_by`,
        `update_date`,
        `remarks`,
        `del_flag`
        )
        values
        (
        ${r'#'}{name},
        ${r'#'}{value},
        ${r'#'}{type},
        ${r'#'}{description},
        ${r'#'}{sort},
        ${r'#'}{parentId},
        ${r'#'}{createBy},
        ${r'#'}{createDate},
        ${r'#'}{updateBy},
        ${r'#'}{updateDate},
        ${r'#'}{remarks},
        ${r'#'}{delFlag}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.DictDO">
        update sys_dict
        <set>
            <if test="name != null">`name` = ${r'#'}{name},</if>
            <if test="value != null">`value` = ${r'#'}{value},</if>
            <if test="type != null">`type` = ${r'#'}{type},</if>
            <if test="description != null">`description` = ${r'#'}{description},</if>
            <if test="sort != null">`sort` = ${r'#'}{sort},</if>
            <if test="parentId != null">`parent_id` = ${r'#'}{parentId},</if>
            <if test="createBy != null">`create_by` = ${r'#'}{createBy},</if>
            <if test="createDate != null">`create_date` = ${r'#'}{createDate},</if>
            <if test="updateBy != null">`update_by` = ${r'#'}{updateBy},</if>
            <if test="updateDate != null">`update_date` = ${r'#'}{updateDate},</if>
            <if test="remarks != null">`remarks` = ${r'#'}{remarks},</if>
            <if test="delFlag != null">`del_flag` = ${r'#'}{delFlag}</if>
        </set>
        where id = ${r'#'}{id}
    </update>

    <delete id="remove">
        delete from sys_dict where id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_dict where id in
        <foreach item="id" collection="array" open="(" separator=","
                 close=")">
            ${r'#'}{id}
        </foreach>
    </delete>

    <select id="listType" resultType="${basePackageName}.${projectName}.core.entity.DictDO">
        select distinct `type` , description from sys_dict
    </select>

</mapper>