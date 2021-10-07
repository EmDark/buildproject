package com.guyi.tools.jdbc.meta.table;

import com.guyi.tools.logging.LoggerUtils;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;

/**
 * @author huliang
 * @date 2021/05/27 16:01
 */
public class MySQLTableCommentGetter implements TableCommentGetter {
  private Connection connection;
  private Map<String, String> commentCache = new HashMap();
  private static Logger logger = LoggerUtils.getLogger(OracleTableCommentGetter.class);

  public MySQLTableCommentGetter(Connection connection) {
    this.connection = connection;
  }

  public String getColumnComment(String tableName, String columnName) {
    return "";
  }

  public String getTableComment(String tableName) {
    try {
      if (this.commentCache.containsKey(tableName)) {
        return (String)this.commentCache.get(tableName);
      } else {
        Statement statement = this.connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT t.TABLE_NAME,t.TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES t  WHERE table_schema = '" + this.connection.getCatalog() + "'");

        while(rs.next()) {
          String tName = rs.getString("TABLE_NAME");
          String fullComment = rs.getString("TABLE_COMMENT");
          int innoDbIndex = fullComment.indexOf("InnoDB");
          this.commentCache.put(tName, fullComment.substring(0, innoDbIndex != -1 ? innoDbIndex : fullComment.length()));
        }

        rs.close();
        statement.close();
        return (String)this.commentCache.get(tableName);
      }
    } catch (SQLException var7) {
      logger.error(var7.getMessage(), var7);
      return null;
    }
  }

  public Connection getConnection() {
    return this.connection;
  }

  public void setConnection(Connection connection) {
    this.connection = connection;
  }
}
