package com.guyi.tools.jdbc.meta.table;

/**
 * @author huliang
 * @date 2021/05/27 16:01
 */
public interface TableMetaListener {
  void preGetMeta(int var1, String var2);

  void afterGetMeta(int var1, TableInfo var2);
}
