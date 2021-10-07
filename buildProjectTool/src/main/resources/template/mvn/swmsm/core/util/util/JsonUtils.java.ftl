package ${basePackageName}.${projectName}.core.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import org.apache.commons.lang3.StringUtils;

/**
* json工具类
*
* @author huliang
* @date 2021/05/29 15:03
*/
public class JsonUtils {

// 定义jackson对象
private static final ObjectMapper MAPPER = new ObjectMapper();

/**
* clone 方法
*
* @param object
* @param clazz
* @param
<T>
    * @return
    */
    public static
    <T> T clone(T object, Class
        <T> clazz) {
            if (object == null) {
            return null;
            } else {
            try {
            String json = toString(object);
            return toObject(json, clazz);
            } catch (Exception var4) {
            throw new RuntimeException("json clone Exception:{}", var4);
            }
            }
            }

            /**
            * toObject 方法
            *
            * @param json
            * @param clazz
            * @return
            */
            public static
            <T> T toObject(String json, Class
                <T> clazz) {
                    try {
                    if (StringUtils.isBlank(json)) {
                    return null;
                    } else {
                    return clazz == String.class ? (T) json : MAPPER.readValue(json, clazz);
                    }
                    } catch (Exception var4) {
                    throw new RuntimeException("json toObject Exception:{}", var4);
                    }
                    }

                    /**
                    * toString 方法
                    *
                    * @param object
                    * @param
                    <T>
                        * @return
                        */
                        private static
                        <T> String toString(T object) {
                            if (object == null) {
                            return "";
                            } else if (object instanceof String) {
                            return (String) object;
                            } else {
                            try {
                            return MAPPER.writeValueAsString(object);
                            } catch (Exception var3) {
                            throw new RuntimeException("json toString Exception:{}", var3);
                            }
                            }
                            }


                            /**
                            * 将json数据转换成pojo对象list
                            * <p>Title: jsonToList</p>
                            * <p>Description: </p>
                            *
                            * @param jsonData
                            * @param beanType
                            * @return
                            */
                            public static
                            <T> List
                                <T> jsonToList(String jsonData, Class
                                    <T> beanType) {
                                        JavaType javaType = MAPPER.getTypeFactory().constructParametricType(List.class,
                                        beanType);
                                        try {
                                        List
                                        <T> list = MAPPER.readValue(jsonData, javaType);
                                            return list;
                                            } catch (Exception e) {
                                            e.printStackTrace();
                                            }

                                            return null;
                                            }

                                            /**
                                            * 将对象转换成json字符串。
                                            * <p>Title: pojoToJson</p>
                                            * <p>Description: </p>
                                            *
                                            * @param data
                                            * @return
                                            */
                                            public static String objectToJson(Object data) {
                                            try {
                                            String string = MAPPER.writeValueAsString(data);
                                            return string;
                                            } catch (JsonProcessingException e) {
                                            e.printStackTrace();
                                            }
                                            return null;
                                            }

                                            /**
                                            * 将json结果集转化为对象
                                            *
                                            * @param jsonData json数据
                                            * @param beanType 对象中的object类型
                                            * @return
                                            */
                                            public static
                                            <T> T jsonToPojo(String jsonData, Class
                                                <T> beanType) {
                                                    try {
                                                    T t = MAPPER.readValue(jsonData, beanType);
                                                    return t;
                                                    } catch (Exception e) {
                                                    e.printStackTrace();
                                                    }
                                                    return null;
                                                    }


                                                    }
