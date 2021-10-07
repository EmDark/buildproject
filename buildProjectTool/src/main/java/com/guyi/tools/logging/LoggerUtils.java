package com.guyi.tools.logging;

import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author huliang
 * @date 2021/05/27 15:52
 */
public class LoggerUtils {
  private static Map<Object, Logger> loggerCache = new HashMap();

  public LoggerUtils() {
  }

  public static Logger getLogger(Class clazz) {
    if (loggerCache.containsKey(clazz)) {
      return loggerCache.get(clazz);
    } else {
      Logger logger = LoggerFactory.getLogger(clazz);
      loggerCache.put(clazz, logger);
      return logger;
    }
  }

  public static Logger getLogger(String name) {
    if (loggerCache.containsKey(name)) {
      return loggerCache.get(name);
    } else {
      Logger logger = LoggerFactory.getLogger(name);
      loggerCache.put(name, logger);
      return logger;
    }
  }
}
