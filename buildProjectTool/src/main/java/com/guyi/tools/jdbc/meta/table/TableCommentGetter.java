package com.guyi.tools.jdbc.meta.table;

/**
 * @author huliang
 * @date 2021/05/27 16:01
 */
public interface TableCommentGetter {
  String getTableComment(String var1);

  String getColumnComment(String var1, String var2);
}
