package com.guyi.tools.jdbc.callback;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionCallback {
  Object doInConnection(Connection var1) throws SQLException;
}
