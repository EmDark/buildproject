package com.guyi.tools.jdbc.meta.table;

/**
 * @author huliang
 * @date 2021/05/27 16:00
 */
public class DefaultTableCommentGetter implements TableCommentGetter {
  public DefaultTableCommentGetter() {
  }

  public String getColumnComment(String tableName, String columnName) {
    return null;
  }

  public String getTableComment(String tableName) {
    return null;
  }
}
