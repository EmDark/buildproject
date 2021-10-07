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
public class OracleTableCommentGetter implements TableCommentGetter {
  private Connection connection;
  private Map<String, String> commentCache = new HashMap();
  private static Logger logger = LoggerUtils.getLogger(OracleTableCommentGetter.class);

  public OracleTableCommentGetter(Connection connection) {
    this.connection = connection;
  }

  public String getColumnComment(String tableName, String columnName) {
    try {
      if (this.commentCache.containsKey(this.getCommentKey(tableName, columnName))) {
        return (String)this.commentCache.get(this.getCommentKey(tableName, columnName));
      } else {
        Statement statement = this.connection.createStatement();
        ResultSet rs = statement.executeQuery("select * from user_col_comments where table_name = '" + tableName.toUpperCase() + "'");

        while(rs.next()) {
          String colName = rs.getString("COLUMN_NAME");
          this.commentCache.put(this.getCommentKey(tableName, colName), rs.getString("COMMENTS"));
        }

        rs.close();
        statement.close();
        return (String)this.commentCache.get(this.getCommentKey(tableName, columnName));
      }
    } catch (SQLException var6) {
      logger.error(var6.getMessage(), var6);
      return null;
    }
  }

  public String getTableComment(String tableName) {
    try {
      if (this.commentCache.containsKey(tableName.toUpperCase())) {
        return (String)this.commentCache.get(tableName.toUpperCase());
      } else {
        Statement statement = this.connection.createStatement();
        ResultSet rs = statement.executeQuery("select * from user_tab_comments where table_name = '" + tableName.toUpperCase() + "'");

        while(rs.next()) {
          this.commentCache.put(tableName.toUpperCase(), rs.getString("COMMENTS"));
        }

        rs.close();
        statement.close();
        return (String)this.commentCache.get(tableName.toUpperCase());
      }
    } catch (SQLException var4) {
      logger.error(var4.getMessage(), var4);
      return null;
    }
  }

  private String getCommentKey(String tableName, String columnName) {
    return tableName.toUpperCase() + "-" + columnName.toUpperCase();
  }
}
