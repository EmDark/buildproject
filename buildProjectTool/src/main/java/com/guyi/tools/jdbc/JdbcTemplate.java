package com.guyi.tools.jdbc;

import com.guyi.tools.jdbc.callback.ConnectionCallback;
import com.guyi.tools.logging.LoggerUtils;
import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;
import org.slf4j.Logger;

/**
 * @author huliang
 * @date 2021/05/27 15:51
 */
public class JdbcTemplate {
  private final Logger logger = LoggerUtils.getLogger(this.getClass());
  private DataSource dataSource;

  public JdbcTemplate() {
  }

  public JdbcTemplate(DataSource dataSource) {
    this.dataSource = dataSource;
  }

  public Object execute(ConnectionCallback action) throws JdbcException {
    Connection conn = null;

    Object var5;
    try {
      conn = this.dataSource.getConnection();
      var5 = action.doInConnection(conn);
    } catch (SQLException var8) {
      throw new JdbcException("Execute exception.", var8);
    } finally {
      this.logger.debug("Returning JDBC Connection to DataSource");
      JdbcUtils.close(conn);
    }

    return var5;
  }

  public DataSource getDataSource() {
    return this.dataSource;
  }

  public void setDataSource(DataSource dataSource) {
    this.dataSource = dataSource;
  }
}
