package com.guyi.tools.jdbc.meta.table;

import com.guyi.tools.common.lang.ObjectUtils;
import com.guyi.tools.jdbc.JdbcUtils;
import com.guyi.tools.logging.LoggerUtils;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import org.slf4j.Logger;

/**
 * @author huliang
 * @date 2021/05/27 16:01
 */
public class TableMetaHelper {
  private static Logger logger = LoggerUtils.getLogger(TableMetaHelper.class);
  private Connection connection;
  private TableMetaListener listener;

  public TableMetaHelper(Connection connection) {
    this.connection = connection;
  }

  public int getTableCount(String schema, String[] types) {
    int count = 0;

    try {
      DatabaseMetaData dm = this.connection.getMetaData();

      ResultSet countTable;
      for(countTable = dm.getTables((String)null, schema, (String)null, types); countTable.next(); ++count) {
      }

      countTable.close();
    } catch (Exception var6) {
      logger.error(var6.getMessage(), var6);
    }

    return count;
  }

  public List<TableInfo> getTableInfo(String[] tableNames, String[] types) {
    return this.getTableInfo(tableNames, (String)null, types);
  }

  public List<TableInfo> getTableInfo(String[] tableNames, String schema, String[] types) {
    List<TableInfo> tableInfoList = new ArrayList();
    logger.info("Start getting information of database ...");

    try {
      if (ObjectUtils.isEmpty(types)) {
        types = new String[]{"TABLE"};
      }

      DatabaseMetaData dbMeta = this.connection.getMetaData();
      if (ObjectUtils.isEmpty(tableNames)) {
        ResultSet rs = this.connection.getMetaData().getTables((String)null, schema, "%", types);
        this.fillTableInfo(tableInfoList, schema, dbMeta, rs);
        JdbcUtils.close(rs);
      } else {
        String[] var9 = tableNames;
        int var8 = tableNames.length;

        for(int var7 = 0; var7 < var8; ++var7) {
          String tableName = var9[var7];
          ResultSet rs = this.connection.getMetaData().getTables((String)null, schema, tableName, types);
          this.fillTableInfo(tableInfoList, schema, dbMeta, rs);
          JdbcUtils.close(rs);
        }
      }

      logger.info("Complete getting information of database.");
      Collections.sort(tableInfoList, new Comparator<TableInfo>() {
        public int compare(TableInfo o1, TableInfo o2) {
          if (o1 != null && o1.getTableName() != null) {
            return o2 == null ? 1 : o1.getTableName().compareTo(o2.getTableName());
          } else {
            return -1;
          }
        }
      });
      return tableInfoList;
    } catch (Exception var11) {
      logger.error(var11.getMessage(), var11);
      return null;
    }
  }

  private void fillTableInfo(List<TableInfo> tableInfoList, String schema, DatabaseMetaData dbMeta, ResultSet rs) throws SQLException {
    TableInfo tableInfo;
    for(; rs.next(); tableInfoList.add(tableInfo)) {
      tableInfo = new TableInfo();
      tableInfo.setTableName(rs.getString("TABLE_NAME"));
      logger.info("Getting information for table [{}] .", tableInfo.getTableName());
      if (this.listener != null) {
        this.listener.preGetMeta(tableInfoList.size() + 1, tableInfo.getTableName());
      }

      TableCommentGetter commentGetter = this.getTableCommentGetter(dbMeta.getConnection());
      logger.debug("Getting {}'s comment .", tableInfo.getTableName());
      tableInfo.setComment(ObjectUtils.isBlank(rs.getString("REMARKS")) ? commentGetter.getTableComment(tableInfo.getTableName()) : rs.getString("REMARKS"));
      logger.debug("Getting {}'s columns .", tableInfo.getTableName());
      ResultSet colRet = dbMeta.getColumns((String)null, schema, tableInfo.getTableName(), "%");
      logger.debug("Getting {}'s primaryKeys .", tableInfo.getTableName());
      ResultSet pkRet = dbMeta.getPrimaryKeys((String)null, schema, tableInfo.getTableName());
      HashMap primaryKeyMap = new HashMap();

      while(pkRet.next()) {
        primaryKeyMap.put(pkRet.getString("COLUMN_NAME"), (Object)null);
      }

      while(colRet.next()) {
        ColumnInfo columnInfo = new ColumnInfo();
        columnInfo.setTableName(tableInfo.getTableName());
        columnInfo.setColumnName(colRet.getString("COLUMN_NAME"));
        columnInfo.setColumnType(colRet.getInt("DATA_TYPE"));
        columnInfo.setColumnTypeName(colRet.getString("TYPE_NAME"));
        columnInfo.setComment(ObjectUtils.isBlank(colRet.getString("REMARKS")) ? commentGetter.getColumnComment(tableInfo.getTableName(), columnInfo.getColumnName()) : colRet.getString("REMARKS"));
        columnInfo.setComments(ObjectUtils.isBlank(colRet.getString("REMARKS")) ? commentGetter.getColumnComment(tableInfo.getTableName(), columnInfo.getColumnName()) : colRet.getString("REMARKS"));
        columnInfo.setLength(colRet.getInt("COLUMN_SIZE"));
        columnInfo.setPrecision(columnInfo.getLength());
        columnInfo.setScale(colRet.getInt("DECIMAL_DIGITS"));
        columnInfo.setNullable("YES".equals(colRet.getString("IS_NULLABLE")));
        columnInfo.setPrimaryKey(primaryKeyMap.containsKey(columnInfo.getColumnName()));
        tableInfo.addColumnInfo(columnInfo.getColumnName(), columnInfo);
      }

      JdbcUtils.close(colRet);
      JdbcUtils.close(pkRet);
      logger.debug("***************************************************");
      if (this.listener != null) {
        this.listener.afterGetMeta(tableInfoList.size() + 1, tableInfo);
      }
    }

  }

  private TableCommentGetter getTableCommentGetter(Connection connection) throws SQLException {
    String dbName = connection.getMetaData().getDatabaseProductName();
    if (dbName != null) {
      if (dbName.toUpperCase().indexOf("ORACLE") != -1) {
        return new OracleTableCommentGetter(connection);
      }

      if (dbName.toUpperCase().indexOf("MYSQL") != -1) {
        return new MySQLTableCommentGetter(connection);
      }
    }

    return new DefaultTableCommentGetter();
  }

  public TableMetaListener getListener() {
    return this.listener;
  }

  public void setListener(TableMetaListener listener) {
    this.listener = listener;
  }
}

