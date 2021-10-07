<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.common.TaskDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.TaskDO">
        select
        `id`,`cron_expression`,`method_name`,`is_concurrent`,`description`,`update_by`,`bean_class`,`create_date`,`job_status`,`job_group`,`update_date`,`create_by`,`spring_bean`,`job_name`
        from sys_task where id = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.TaskDO">
        select
        `id`,`cron_expression`,`method_name`,`is_concurrent`,`description`,`update_by`,`bean_class`,`create_date`,`job_status`,`job_group`,`update_date`,`create_by`,`spring_bean`,`job_name`
        from sys_task
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="cronExpression != null and cronExpression != ''"> and cron_expression = ${r'#'}{cronExpression}
            </if>
            <if test="methodName != null and methodName != ''"> and method_name = ${r'#'}{methodName}</if>
            <if test="isConcurrent != null and isConcurrent != ''"> and is_concurrent = ${r'#'}{isConcurrent}</if>
            <if test="description != null and description != ''"> and description = ${r'#'}{description}</if>
            <if test="updateBy != null and updateBy != ''"> and update_by = ${r'#'}{updateBy}</if>
            <if test="beanClass != null and beanClass != ''"> and bean_class = ${r'#'}{beanClass}</if>
            <if test="createDate != null and createDate != ''"> and create_date = ${r'#'}{createDate}</if>
            <if test="jobStatus != null and jobStatus != ''"> and job_status = ${r'#'}{jobStatus}</if>
            <if test="jobGroup != null and jobGroup != ''"> and job_group = ${r'#'}{jobGroup}</if>
            <if test="updateDate != null and updateDate != ''"> and update_date = ${r'#'}{updateDate}</if>
            <if test="createBy != null and createBy != ''"> and create_by = ${r'#'}{createBy}</if>
            <if test="springBean != null and springBean != ''"> and spring_bean = ${r'#'}{springBean}</if>
            <if test="jobName != null and jobName != ''"> and job_name = ${r'#'}{jobName}</if>
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
        select count(*) from sys_task
        <where>
            <if test="id != null and id != ''"> and id = ${r'#'}{id}</if>
            <if test="cronExpression != null and cronExpression != ''"> and cron_expression = ${r'#'}{cronExpression}
            </if>
            <if test="methodName != null and methodName != ''"> and method_name = ${r'#'}{methodName}</if>
            <if test="isConcurrent != null and isConcurrent != ''"> and is_concurrent = ${r'#'}{isConcurrent}</if>
            <if test="description != null and description != ''"> and description = ${r'#'}{description}</if>
            <if test="updateBy != null and updateBy != ''"> and update_by = ${r'#'}{updateBy}</if>
            <if test="beanClass != null and beanClass != ''"> and bean_class = ${r'#'}{beanClass}</if>
            <if test="createDate != null and createDate != ''"> and create_date = ${r'#'}{createDate}</if>
            <if test="jobStatus != null and jobStatus != ''"> and job_status = ${r'#'}{jobStatus}</if>
            <if test="jobGroup != null and jobGroup != ''"> and job_group = ${r'#'}{jobGroup}</if>
            <if test="updateDate != null and updateDate != ''"> and update_date = ${r'#'}{updateDate}</if>
            <if test="createBy != null and createBy != ''"> and create_by = ${r'#'}{createBy}</if>
            <if test="springBean != null and springBean != ''"> and spring_bean = ${r'#'}{springBean}</if>
            <if test="jobName != null and jobName != ''"> and job_name = ${r'#'}{jobName}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.TaskDO" useGeneratedKeys="true"
            keyProperty="id">
        insert into sys_task
        (
        `cron_expression`,
        `method_name`,
        `is_concurrent`,
        `description`,
        `update_by`,
        `bean_class`,
        `create_date`,
        `job_status`,
        `job_group`,
        `update_date`,
        `create_by`,
        `spring_bean`,
        `job_name`
        )
        values
        (
        ${r'#'}{cronExpression},
        ${r'#'}{methodName},
        ${r'#'}{isConcurrent},
        ${r'#'}{description},
        ${r'#'}{updateBy},
        ${r'#'}{beanClass},
        ${r'#'}{createDate},
        ${r'#'}{jobStatus},
        ${r'#'}{jobGroup},
        ${r'#'}{updateDate},
        ${r'#'}{createBy},
        ${r'#'}{springBean},
        ${r'#'}{jobName}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.TaskDO">
        update sys_task
        <set>
            <if test="cronExpression != null">`cron_expression` = ${r'#'}{cronExpression},</if>
            <if test="methodName != null">`method_name` = ${r'#'}{methodName},</if>
            <if test="isConcurrent != null">`is_concurrent` = ${r'#'}{isConcurrent},</if>
            <if test="description != null">`description` = ${r'#'}{description},</if>
            <if test="updateBy != null">`update_by` = ${r'#'}{updateBy},</if>
            <if test="beanClass != null">`bean_class` = ${r'#'}{beanClass},</if>
            <if test="createDate != null">`create_date` = ${r'#'}{createDate},</if>
            <if test="jobStatus != null">`job_status` = ${r'#'}{jobStatus},</if>
            <if test="jobGroup != null">`job_group` = ${r'#'}{jobGroup},</if>
            <if test="updateDate != null">`update_date` = ${r'#'}{updateDate},</if>
            <if test="createBy != null">`create_by` = ${r'#'}{createBy},</if>
            <if test="springBean != null">`spring_bean` = ${r'#'}{springBean},</if>
            <if test="jobName != null">`job_name` = ${r'#'}{jobName}</if>
        </set>
        where id = ${r'#'}{id}
    </update>

    <delete id="remove">
        delete from sys_task where id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_task where id in
        <foreach item="id" collection="array" open="(" separator="," close=")">
            ${r'#'}{id}
        </foreach>
    </delete>

</mapper>