package com.guyi.tools;


import com.guyi.tools.constant.Constant;
import com.guyi.tools.constant.Constants;
import com.guyi.tools.jdbc.meta.table.ColumnInfo;
import com.guyi.tools.jdbc.meta.table.TableInfo;
import com.guyi.tools.util.DateUtils;
import com.guyi.tools.util.DirUtils;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

/**
 * 代码生成器   工具类
 */
public class GenUtils {


  public static List<String> getTemplates() {
    List<String> templates = new ArrayList<String>();
    templates.add("./template/common/domain.java.vm");
    templates.add("./template/common/Dao.java.vm");
    templates.add("./template/common/Mapper.java.vm");
    templates.add("./template/common/Mapper.xml.vm");
    templates.add("./template/common/Service.java.vm");
    templates.add("./template/common/ServiceImpl.java.vm");
    templates.add("./template/common/Controller.java.vm");
    templates.add("./template/common/list.html.vm");
    templates.add("./template/common/add.html.vm");
    templates.add("./template/common/edit.html.vm");
    templates.add("./template/common/list.js.vm");
    templates.add("./template/common/add.js.vm");
    templates.add("./template/common/edit.js.vm");
    templates.add("./template/common/menu.sql.vm");
    return templates;
  }

  /**
   * 生成代码
   */


  public static void generatorCode(TableInfo tableDO, ZipOutputStream zip, String genDir,
      String packageName) {
    //配置信息
    Configuration config = getConfig();
    config.setProperty("package",packageName);
    //表名转换成Java类名
    String className = tableToJava(tableDO.getTableName(), config.getString("tablePrefix"),
        config.getString("autoRemovePre"));
    tableDO.setClassName(className);
    tableDO.setClassname(StringUtils.uncapitalize(className));

    //列信息
    for (Entry<String, ColumnInfo> entry : tableDO.getColumnMap().entrySet()) {
      //没主键，则第一个字段为主键

      ColumnInfo columnDO = entry.getValue();
      if (tableDO.getPk() == null&&columnDO.isPrimaryKey()) {
        tableDO.setPk(columnDO);
      }
      columnDO.setDataType(columnDO.getColumnTypeName().toLowerCase());

      //列名转换成Java属性名
      String attrName = columnToJava(columnDO.getColumnName());
      columnDO.setAttrName(attrName);
      columnDO.setAttrname(StringUtils.uncapitalize(attrName));

      //列的数据类型，转换成Java类型
      String attrType = config.getString(columnDO.getDataType(), "unknowType");
      columnDO.setAttrType(attrType);

    }

    //设置velocity资源加载器
    Properties prop = new Properties();
    prop.put("file.resource.loader.class",
        "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
    Velocity.init(prop);

    //封装模板数据
    Map<String, Object> map = new HashMap<String, Object>(16);
    map.put("tableName", tableDO.getTableName());
    map.put("comments", tableDO.getComment());
    map.put("pk", tableDO.getPk());
    map.put("className", tableDO.getClassName());
    map.put("classname", tableDO.getClassname());
    map.put("pathName",
        config.getString("package").substring(config.getString("package").lastIndexOf(".") + 1));
    map.put("columns", tableDO.getColumnMap().values());
    map.put("package", config.getString("package"));
    map.put("author", config.getString("author"));
    map.put("email", config.getString("email"));
    map.put("datetime", DateUtils.format(new Date(), DateUtils.DATE_TIME_PATTERN));
    VelocityContext context = new VelocityContext(map);

    //获取模板列表
    List<String> templates = getTemplates();
    for (String template : templates) {
      //渲染模板
      StringWriter sw = new StringWriter();
      Template tpl = Velocity.getTemplate(template, "UTF-8");
      tpl.merge(context, sw);
      String fileName = genDir +
          getFileName(template, tableDO.getClassname(), tableDO.getClassName(),
              config.getString("package")
                  .substring(config.getString("package").lastIndexOf(".") + 1));
      String path = fileName.substring(0, fileName.lastIndexOf('/'));
      DirUtils.mkdir(path);
      try {
        BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileName), Constants.DEFAULT_CHARSET));
        //写到文件
        IOUtils.write(sw.toString(), out);
        out.close();
        IOUtils.closeQuietly(sw);
      } catch (IOException e) {
        throw new RuntimeException("渲染模板失败，表名：" + tableDO.getTableName(), e);
      }


    }
  }


  /**
   * 列名转换成Java属性名
   */
  public static String columnToJava(String columnName) {
    return WordUtils.capitalizeFully(columnName, new char[]{'_'}).replace("_", "");
  }

  /**
   * 表名转换成Java类名
   */
  public static String tableToJava(String tableName, String tablePrefix, String autoRemovePre) {
    if (Constant.AUTO_REOMVE_PRE.equals(autoRemovePre)) {
      tableName = tableName.substring(tableName.indexOf("_") + 1);
    }
    if (StringUtils.isNotBlank(tablePrefix)) {
      tableName = tableName.replace(tablePrefix, "");
    }

    return columnToJava(tableName);
  }

  /**
   * 获取配置信息
   */
  public static Configuration getConfig() {
    try {
      return new PropertiesConfiguration("generator.properties");
    } catch (ConfigurationException e) {
      throw new RuntimeException("获取配置文件失败，", e);
    }
  }

  /**
   * 获取文件名
   */
  public static String getFileName(String template, String classname, String className) {
    if (template.contains("domain.java.vm")) {
      return className + "DO.java";
    }

    if (template.contains("Dao.java.vm")) {
      return className + "Dao.java";
    }

    if (template.contains("Mapper.java.vm")) {
      return className + "Mapper.java";
    }

    if (template.contains("Service.java.vm")) {
      return className + "Service.java";
    }

    if (template.contains("ServiceImpl.java.vm")) {
      return className
          + "ServiceImpl.java";
    }

    if (template.contains("Controller.java.vm")) {
      return className + "Controller.java";
    }

    if (template.contains("Mapper.xml.vm")) {
      return className + "Mapper.xml";
    }

    if (template.contains("list.html.vm")) {
      return classname + ".html";
    }
    if (template.contains("add.html.vm")) {
      return classname + File.separator + "add.html";
    }
    if (template.contains("edit.html.vm")) {
      return classname + File.separator + "edit.html";
    }

    if (template.contains("list.js.vm")) {
      return
          classname + ".js";
      //		+ "modules" + File.separator + "generator" + File.separator + className.toLowerCase() + ".js";
    }
    if (template.contains("add.js.vm")) {
      return classname + File.separator
          + "add.js";
    }
    if (template.contains("edit.js.vm")) {
      return classname + File.separator
          + "edit.js";
    }
    if (template.contains("menu.sql.vm")) {
      return className.toLowerCase() + "_menu.sql";
    }
    return null;
  }


  /**
   * 获取文件名
   */
  public static String getFileName(String template, String classname, String className,
      String packageName) {
    String packagePath = "main" + File.separator + "java" + File.separator;
    //String modulesname=config.getString("packageName");
    if (StringUtils.isNotBlank(packageName)) {
      packagePath += packageName.replace(".", File.separator) + File.separator;
    }

    if (template.contains("domain.java.vm")) {
      return packagePath + "domain" + File.separator + className + "DO.java";
    }

    if (template.contains("Dao.java.vm")) {
      return packagePath + "dao" + File.separator + className + "Dao.java";
    }

    if (template.contains("Mapper.java.vm")) {
      return packagePath + "dao" + File.separator + className + "Mapper.java";
    }

    if (template.contains("Service.java.vm")) {
      return packagePath + "service" + File.separator + className + "Service.java";
    }

    if (template.contains("ServiceImpl.java.vm")) {
      return packagePath + "service" + File.separator + "impl" + File.separator + className
          + "ServiceImpl.java";
    }

    if (template.contains("Controller.java.vm")) {
      return packagePath + "controller" + File.separator + className + "Controller.java";
    }

    if (template.contains("Mapper.xml.vm")) {
      return "main" + File.separator + "resources" + File.separator + "mapper" + File.separator
          + packageName + File.separator + className + "Mapper.xml";
    }

    if (template.contains("list.html.vm")) {
      return "main" + File.separator + "resources" + File.separator + "templates" + File.separator
          + packageName + File.separator + classname + File.separator + classname + ".html";
      //				+ "modules" + File.separator + "generator" + File.separator + className.toLowerCase() + ".html";
    }
    if (template.contains("add.html.vm")) {
      return "main" + File.separator + "resources" + File.separator + "templates" + File.separator
          + packageName + File.separator + classname + File.separator + "add.html";
    }
    if (template.contains("edit.html.vm")) {
      return "main" + File.separator + "resources" + File.separator + "templates" + File.separator
          + packageName + File.separator + classname + File.separator + "edit.html";
    }

    if (template.contains("list.js.vm")) {
      return "main" + File.separator + "resources" + File.separator + "static" + File.separator
          + "js" + File.separator
          + "appjs" + File.separator + packageName + File.separator + classname + File.separator
          + classname + ".js";
      //		+ "modules" + File.separator + "generator" + File.separator + className.toLowerCase() + ".js";
    }
    if (template.contains("add.js.vm")) {
      return "main" + File.separator + "resources" + File.separator + "static" + File.separator
          + "js" + File.separator
          + "appjs" + File.separator + packageName + File.separator + classname + File.separator
          + "add.js";
    }
    if (template.contains("edit.js.vm")) {
      return "main" + File.separator + "resources" + File.separator + "static" + File.separator
          + "js" + File.separator
          + "appjs" + File.separator + packageName + File.separator + classname + File.separator
          + "edit.js";
    }

    if (template.contains("menu.sql.vm")) {
      return className.toLowerCase() + "_menu.sql";
    }

    return null;
  }
}
