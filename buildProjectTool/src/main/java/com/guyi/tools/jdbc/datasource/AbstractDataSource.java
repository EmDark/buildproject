package com.guyi.tools.jdbc.datasource;

import com.guyi.tools.logging.LoggerUtils;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.sql.DataSource;
import org.slf4j.Logger;
/**
 * @author huliang
 * @date 2021/05/27 15:56
 */
public abstract class AbstractDataSource implements DataSource {
  protected final Logger logger = LoggerUtils.getLogger(this.getClass());

  public AbstractDataSource() {
  }

  public int getLoginTimeout() throws SQLException {
    return 0;
  }

  public void setLoginTimeout(int timeout) throws SQLException {
    throw new UnsupportedOperationException("setLoginTimeout");
  }

  public PrintWriter getLogWriter() {
    throw new UnsupportedOperationException("getLogWriter");
  }

  public void setLogWriter(PrintWriter pw) throws SQLException {
    throw new UnsupportedOperationException("setLogWriter");
  }

  public Object unwrap(Class iface) throws SQLException {
    if (!DataSource.class.equals(iface)) {
      throw new SQLException("DataSource of type [" + this.getClass().getName() + "] can only be unwrapped as [javax.sql.DataSource], not as [" + iface.getName());
    } else {
      return this;
    }
  }

  public boolean isWrapperFor(Class iface) throws SQLException {
    return DataSource.class.equals(iface);
  }
}
