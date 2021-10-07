package com.guyi.tools.common.lang.date;

/**
 * @author huliang
 * @date 2021/05/27 15:49
 */
public class DateParseException extends RuntimeException {
  private static final long serialVersionUID = 2450611088177579513L;

  public DateParseException() {
  }

  public DateParseException(String message, Throwable cause) {
    super(message, cause);
  }

  public DateParseException(String message) {
    super(message);
  }

  public DateParseException(Throwable cause) {
    super(cause);
  }
}
