package com.guyi.tools.jdbc.meta.table;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 * @author huliang
 * @date 2021/05/27 16:01
 */
public class TableInfo {
  private String tableName;
  private String comment;

  //表的列名(不包含主键)
  private TreeMap<String, ColumnInfo> columnMap = new TreeMap();

  //表的主键
  private ColumnInfo pk;

  //类名(第一个字母大写)，如：sys_user => SysUser
  private String className;
  //类名(第一个字母小写)，如：sys_user => sysUser
  private String classname;

  public TreeMap<String, ColumnInfo> getColumnMap() {
    return columnMap;
  }

  public void setColumnMap(
      TreeMap<String, ColumnInfo> columnMap) {
    this.columnMap = columnMap;
  }

  public ColumnInfo getPk() {
    return pk;
  }

  public void setPk(ColumnInfo pk) {
    this.pk = pk;
  }

  public String getClassName() {
    return className;
  }

  public void setClassName(String className) {
    this.className = className;
  }

  public String getClassname() {
    return classname;
  }

  public void setClassname(String classname) {
    this.classname = classname;
  }

  public TableInfo() {
  }

  public void addColumnInfo(String columnName, ColumnInfo columnInfo) {
    this.columnMap.put(columnName, columnInfo);
  }

  public ColumnInfo getColumnInfo(String columnName) {
    return this.columnMap.get(columnName);
  }

  public String getTableName() {
    return this.tableName;
  }

  public void setTableName(String tableName) {
    this.tableName = tableName;
  }

  public String getComment() {
    return this.comment;
  }

  public void setComment(String comment) {
    this.comment = comment;
  }
}
