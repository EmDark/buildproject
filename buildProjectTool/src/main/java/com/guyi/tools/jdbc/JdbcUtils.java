package com.guyi.tools.jdbc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author huliang
 * @date 2021/05/27 15:52
 */
public class JdbcUtils {
  public JdbcUtils() {
  }

  public static void close(Connection conn) throws JdbcException {
    try {
      if (conn != null) {
        conn.close();
      }

    } catch (SQLException var2) {
      throw new JdbcException("Can not close connection.", var2);
    }
  }

  public static void close(Statement statement) throws JdbcException {
    try {
      if (statement != null) {
        statement.close();
      }

    } catch (SQLException var2) {
      throw new JdbcException("Can not close statement.", var2);
    }
  }

  public static void close(ResultSet resultSet) throws JdbcException {
    try {
      if (resultSet != null) {
        resultSet.close();
      }

    } catch (SQLException var2) {
      throw new JdbcException("Can not close resultSet.", var2);
    }
  }
}
