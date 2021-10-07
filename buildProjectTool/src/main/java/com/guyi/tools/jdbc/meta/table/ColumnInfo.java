package com.guyi.tools.jdbc.meta.table;

/**
 * @author huliang
 * @date 2021/05/27 16:00
 */
public class ColumnInfo {
  private String tableName;
  private String columnName;
  private int columnType;
  private String columnTypeName;
  private boolean nullable;
  private boolean primaryKey;
  private int length;
  private int precision;
  private int scale;
  private String comment;

  // 列名类型
  private String dataType;
  // 列名备注
  private String comments;

  // 属性名称(第一个字母大写)，如：user_name => UserName
  private String attrName;
  // 属性名称(第一个字母小写)，如：user_name => userName
  private String attrname;
  // 属性类型
  private String attrType;
  // auto_increment
  private String extra;

  public ColumnInfo() {
  }

  public String getColumnName() {
    return this.columnName;
  }

  public void setColumnName(String columnName) {
    this.columnName = columnName;
  }

  public int getLength() {
    return this.length;
  }

  public void setLength(int length) {
    this.length = length;
  }

  public int getPrecision() {
    return this.precision;
  }

  public void setPrecision(int precision) {
    this.precision = precision;
  }

  public String getComment() {
    return this.comment;
  }

  public void setComment(String comment) {
    this.comment = comment;
  }

  public boolean isNullable() {
    return this.nullable;
  }

  public void setNullable(boolean nullable) {
    this.nullable = nullable;
  }

  public boolean isPrimaryKey() {
    return this.primaryKey;
  }

  public void setPrimaryKey(boolean primaryKey) {
    this.primaryKey = primaryKey;
  }

  public int getColumnType() {
    return this.columnType;
  }

  public void setColumnType(int columnType) {
    this.columnType = columnType;
  }

  public String getColumnTypeName() {
    return this.columnTypeName;
  }

  public void setColumnTypeName(String columnTypeName) {
    this.columnTypeName = columnTypeName;
  }

  public int getScale() {
    return this.scale;
  }

  public void setScale(int scale) {
    this.scale = scale;
  }

  public String getTableName() {
    return this.tableName;
  }

  public void setTableName(String tableName) {
    this.tableName = tableName;
  }

  public String getDataType() {
    return dataType;
  }

  public void setDataType(String dataType) {
    this.dataType = dataType;
  }

  public String getComments() {
    return comments;
  }

  public void setComments(String comments) {
    this.comments = comments;
  }

  public String getAttrName() {
    return attrName;
  }

  public void setAttrName(String attrName) {
    this.attrName = attrName;
  }

  public String getAttrname() {
    return attrname;
  }

  public void setAttrname(String attrname) {
    this.attrname = attrname;
  }

  public String getAttrType() {
    return attrType;
  }

  public void setAttrType(String attrType) {
    this.attrType = attrType;
  }

  public String getExtra() {
    return extra;
  }

  public void setExtra(String extra) {
    this.extra = extra;
  }


}
