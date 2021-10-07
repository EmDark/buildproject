package com.guyi.tools.common.lang;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Map;

/**
 * @author huliang
 * @date 2021/05/27 15:48
 */
public class ObjectUtils {

  public ObjectUtils() {
  }

  public static String toString(Object obj) {
    return obj == null ? "" : obj.toString();
  }

  public static <T> T defaultIfNull(T object, T defaultValue) {
    return object != null ? object : defaultValue;
  }

  public static boolean isEmpty(Object object) {
    if (object == null) {
      return true;
    } else if (object.getClass().isArray()) {
      return Array.getLength(object) == 0;
    } else if (object instanceof String) {
      return isEmpty((String) object);
    } else if (object instanceof Collection) {
      return isEmpty((Collection) object);
    } else {
      return object instanceof Map ? isEmpty((Map) object) : false;
    }
  }

  public static boolean isBlank(Object object) {
    if (object == null) {
      return true;
    } else if (object.getClass().isArray()) {
      return Array.getLength(object) == 0;
    } else if (object instanceof String) {
      return isBlank((String) object);
    } else if (object instanceof Collection) {
      return isEmpty((Collection) object);
    } else {
      return object instanceof Map ? isEmpty((Map) object) : false;
    }
  }

  public static boolean isEmpty(String object) {
    return object == null || object.length() == 0;
  }

  public static boolean isBlank(String object) {
    return object == null || object.trim().length() == 0;
  }

  public static boolean isEmpty(Collection object) {
    return object == null || object.size() == 0;
  }

  public static boolean isEmpty(Map object) {
    return object == null || object.size() == 0;
  }

  public static boolean isNotEmpty(Object object) {
    return !isEmpty(object);
  }

  public static boolean isNotBlank(Object object) {
    return !isBlank(object);
  }

  public static boolean isNotEmpty(String object) {
    return !isEmpty(object);
  }

  public static boolean isNotBlank(String object) {
    return !isBlank(object);
  }

  public static boolean isNotEmpty(Collection object) {
    return !isEmpty(object);
  }

  public static boolean isNotEmpty(Map object) {
    return !isEmpty(object);
  }

  public static boolean isEquals(Object object1, Object object2) {
    if (object1 == object2) {
      return true;
    } else {
      return object1 != null && object2 != null ? object1.equals(object2) : false;
    }
  }

  public static boolean isNotEquals(Object object1, Object object2) {
    return !isEquals(object1, object2);
  }

  public static <T extends Comparable> T min(T c1, T c2) {
    if (c1 != null && c2 != null) {
      return c1.compareTo(c2) < 1 ? c1 : c2;
    } else {
      return c1 != null ? c1 : c2;
    }
  }

  public static <T extends Comparable> T max(T c1, T c2) {
    if (c1 != null && c2 != null) {
      return c1.compareTo(c2) >= 0 ? c1 : c2;
    } else {
      return c1 != null ? c1 : c2;
    }
  }
}
