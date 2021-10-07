<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackageName}.${projectName}.core.dao.system.UserDao">

    <select id="get" resultType="${basePackageName}.${projectName}.core.entity.UserDO">
        select
        `user_id`,`username`,`name`,`password`,`dept_id`,`email`,`mobile`,`status`,`user_id_create`,`gmt_create`,`gmt_modified`,`sex`,`birth`,`pic_id`,`live_address`,`hobby`,`province`,`city`,`district`
        from sys_user where user_id = ${r'#'}{value}
    </select>

    <select id="list" resultType="${basePackageName}.${projectName}.core.entity.UserDO">
        select
        `user_id`,`username`,`name`,`password`,`dept_id`,`email`,`mobile`,`status`,`user_id_create`,`gmt_create`,`gmt_modified`,`sex`,`birth`,`pic_id`,`live_address`,`hobby`,`province`,`city`,`district`
        from sys_user
        <where>
            <if test="userId != null and userId != ''">and user_id = ${r'#'}{userId}</if>
            <if test="username != null and username != ''">and username = ${r'#'}{username}</if>
            <if test="name != null and name != ''">and name = ${r'#'}{name}</if>
            <if test="password != null and password != ''">and password = ${r'#'}{password}</if>
            <if test="deptId != null and deptId != ''">and dept_id = ${r'#'}{deptId}</if>
            <if test="deptIds != null and deptIds.size() > 0">and dept_id in
                <foreach collection="deptIds" item="item" index="index" separator="," open="(" close=")">
                    ${r'#'}{item}
                </foreach>
            </if>
            <if test="email != null and email != ''">and email = ${r'#'}{email}</if>
            <if test="mobile != null and mobile != ''">and mobile = ${r'#'}{mobile}</if>
            <if test="status != null and status != ''">and status = ${r'#'}{status}</if>
            <if test="userIdCreate != null and userIdCreate != ''">and user_id_create = ${r'#'}{userIdCreate}</if>
            <if test="gmtCreate != null and gmtCreate != ''">and gmt_create = ${r'#'}{gmtCreate}</if>
            <if test="gmtModified != null and gmtModified != ''">and gmt_modified = ${r'#'}{gmtModified}</if>
            <if test="sex != null and sex != ''">and sex = ${r'#'}{sex}</if>
            <if test="birth != null and birth != ''">and birth = ${r'#'}{birth}</if>
            <if test="picId != null and picId != ''">and pic_id = ${r'#'}{picId}</if>
            <if test="liveAddress != null and liveAddress != ''">and live_address = ${r'#'}{liveAddress}</if>
            <if test="hobby != null and hobby != ''">and hobby = ${r'#'}{hobby}</if>
            <if test="province != null and province != ''">and province = ${r'#'}{province}</if>
            <if test="city != null and city != ''">and city = ${r'#'}{city}</if>
            <if test="district != null and district != ''">and district = ${r'#'}{district}</if>
        </where>
        <choose>
            <when test="sort != null and sort.trim() != ''">
                order by ${r'$'}{sort} ${r'$'}{order}
            </when>
            <otherwise>
                order by user_id desc
            </otherwise>
        </choose>
        <if test="offset != null and limit != null">
            limit ${r'#'}{offset}, ${r'#'}{limit}
        </if>
    </select>

    <select id="count" resultType="int">
        select count(*) from sys_user
        <where>
            <if test="userId != null and userId != ''">and user_id = ${r'#'}{userId}</if>
            <if test="username != null and username != ''">and username = ${r'#'}{username}</if>
            <if test="name != null and name != ''">and name = ${r'#'}{name}</if>
            <if test="password != null and password != ''">and password = ${r'#'}{password}</if>
            <if test="deptId != null and deptId != ''">and dept_id = ${r'#'}{deptId}</if>
            <if test="email != null and email != ''">and email = ${r'#'}{email}</if>
            <if test="mobile != null and mobile != ''">and mobile = ${r'#'}{mobile}</if>
            <if test="status != null and status != ''">and status = ${r'#'}{status}</if>
            <if test="userIdCreate != null and userIdCreate != ''">and user_id_create = ${r'#'}{userIdCreate}</if>
            <if test="gmtCreate != null and gmtCreate != ''">and gmt_create = ${r'#'}{gmtCreate}</if>
            <if test="gmtModified != null and gmtModified != ''">and gmt_modified = ${r'#'}{gmtModified}</if>
            <if test="sex != null and sex != ''">and sex = ${r'#'}{sex}</if>
            <if test="birth != null and birth != ''">and birth = ${r'#'}{birth}</if>
            <if test="picId != null and picId != ''">and pic_id = ${r'#'}{picId}</if>
            <if test="liveAddress != null and liveAddress != ''">and live_address = ${r'#'}{liveAddress}</if>
            <if test="hobby != null and hobby != ''">and hobby = ${r'#'}{hobby}</if>
            <if test="province != null and province != ''">and province = ${r'#'}{province}</if>
            <if test="city != null and city != ''">and city = ${r'#'}{city}</if>
            <if test="district != null and district != ''">and district = ${r'#'}{district}</if>
        </where>
    </select>

    <insert id="save" parameterType="${basePackageName}.${projectName}.core.entity.UserDO" useGeneratedKeys="true"
            keyProperty="userId">
        insert into sys_user
        (
        `username`,
        `name`,
        `password`,
        `dept_id`,
        `email`,
        `mobile`,
        `status`,
        `user_id_create`,
        `gmt_create`,
        `gmt_modified`,
        `sex`,
        `birth`,
        `pic_id`,
        `live_address`,
        `hobby`,
        `province`,
        `city`,
        `district`
        )
        values
        (
        ${r'#'}{username},
        ${r'#'}{name},
        ${r'#'}{password},
        ${r'#'}{deptId},
        ${r'#'}{email},
        ${r'#'}{mobile},
        ${r'#'}{status},
        ${r'#'}{userIdCreate},
        ${r'#'}{gmtCreate},
        ${r'#'}{gmtModified},
        ${r'#'}{sex},
        ${r'#'}{birth},
        ${r'#'}{picId},
        ${r'#'}{liveAddress},
        ${r'#'}{hobby},
        ${r'#'}{province},
        ${r'#'}{city},
        ${r'#'}{district}
        )
    </insert>

    <update id="update" parameterType="${basePackageName}.${projectName}.core.entity.UserDO">
        update sys_user
        <set>
            <if test="username != null">`username` = ${r'#'}{username},</if>
            <if test="name != null">`name` = ${r'#'}{name},</if>
            <if test="password != null">`password` = ${r'#'}{password},</if>
            <if test="deptId != null">`dept_id` = ${r'#'}{deptId},</if>
            <if test="email != null">`email` = ${r'#'}{email},</if>
            <if test="mobile != null">`mobile` = ${r'#'}{mobile},</if>
            <if test="status != null">`status` = ${r'#'}{status},</if>
            <if test="userIdCreate != null">`user_id_create` = ${r'#'}{userIdCreate},</if>
            <if test="gmtCreate != null">`gmt_create` = ${r'#'}{gmtCreate},</if>
            <if test="gmtModified != null">`gmt_modified` = ${r'#'}{gmtModified},</if>
            <if test="sex != null">`sex` = ${r'#'}{sex},</if>
            <if test="birth != null">`birth` = ${r'#'}{birth},</if>
            <if test="picId != null">`pic_id` = ${r'#'}{picId},</if>
            <if test="liveAddress != null">`live_address` = ${r'#'}{liveAddress},</if>
            <if test="hobby != null">`hobby` = ${r'#'}{hobby},</if>
            <if test="province != null">`province` = ${r'#'}{province},</if>
            <if test="city != null">`city` = ${r'#'}{city},</if>
            <if test="district != null">`district` = ${r'#'}{district}</if>
        </set>
        where user_id = ${r'#'}{userId}
    </update>

    <delete id="remove">
        delete from sys_user where user_id = ${r'#'}{value}
    </delete>

    <delete id="batchRemove">
        delete from sys_user where user_id in
        <foreach item="userId" collection="array" open="(" separator="," close=")">
            ${r'#'}{userId}
        </foreach>
    </delete>

    <select id="listAllDept" resultType="long">
        select DISTINCT dept_id from sys_user
    </select>
</mapper>