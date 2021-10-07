package com.guyi.tools;

import com.guyi.tools.jdbc.JdbcTemplate;
import com.guyi.tools.jdbc.callback.ConnectionCallback;
import com.guyi.tools.jdbc.datasource.DriverManagerDataSource;
import com.guyi.tools.jdbc.meta.table.ColumnInfo;
import com.guyi.tools.jdbc.meta.table.TableInfo;
import com.guyi.tools.jdbc.meta.table.TableMetaHelper;
import com.guyi.tools.util.DirUtils;
import java.io.ByteArrayOutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;

/**
 * @author huliang
 * @date 2021/06/02 14:57
 */
public class GenFrontAndEntity {

  private static JdbcTemplate jdbcTemplate;
  private static String driverClassName = "com.mysql.cj.jdbc.Driver";
  private static String url = "jdbc:mysql://localhost:3306/quant?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai";
  private static String username = "root";
  private static String password = "huliang1211";

  public static JdbcTemplate getJdbcTemplate() {
    if (jdbcTemplate == null) {
      DriverManagerDataSource dataSource = new DriverManagerDataSource();
      dataSource.setDriverClassName(driverClassName);
      dataSource.setUrl(url);
      dataSource.setUsername(username);
      dataSource.setPassword(password);

      jdbcTemplate = new JdbcTemplate(dataSource);
    }

    return jdbcTemplate;
  }

  @SuppressWarnings("unchecked")
  public static void main(String[] args) throws Exception {
    final String baseDirName = "/Users/didi/workSpace/jQuant";
    final String basePackageName = "com.guyi";
    final String projectName = "jQuant";
    final String tablePrefix = "";
    final String[] tableNames = {
        "trade_dates"
    };

    String packageName = basePackageName + "." + projectName;
    final String schema = "quant";

    String adminBaseDirName = baseDirName + "/" + projectName + "-admin";

    String genDir = adminBaseDirName + "/src/main/resources/gen/";

    DirUtils.mkdir(genDir);

    List<TableInfo> tableInfoList = (List<TableInfo>) getJdbcTemplate()
        .execute(new ConnectionCallback() {
          public Object doInConnection(Connection connection) throws SQLException {
            TableMetaHelper metaHelper = new TableMetaHelper(connection);
            return metaHelper.getTableInfo(tableNames, schema, new String[]{"TABLE"});
          }
        });

    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
    ZipOutputStream zip = new ZipOutputStream(outputStream);
    //生成代码
    for (TableInfo t :
        tableInfoList) {
      GenUtils.generatorCode(t, zip, genDir,packageName);
    }

    IOUtils.closeQuietly(zip);
  }
}
