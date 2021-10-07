package com.guyi.tools.jdbc;

/**
 * @author huliang
 * @date 2021/05/27 15:51
 */
public class JdbcException extends RuntimeException {
  private static final long serialVersionUID = 8445716402161469744L;

  public JdbcException() {
  }

  public JdbcException(String message) {
    super(message);
  }

  public JdbcException(Throwable cause) {
    super(cause);
  }

  public JdbcException(String message, Throwable cause) {
    super(message, cause);
  }
}
