package com.guyi.tools;

import com.guyi.tools.util.DirUtils;
import com.guyi.tools.util.GenerateUtils;
import freemarker.cache.ClassTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.TemplateExceptionHandler;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GenSpringMyBatisMvnProject {

  private static final String DEFAULT_CHARSET = "UTF-8";
  private static final String DEFAULT_DATABASE = "mysql";

  public static void main(String[] args) throws Exception {

    final String baseDirName = "/Users/didi/workSpace/jQuant";
    final String basePackageName = "com.guyi";
    final String projectName = "jQuant";
    String driverClassName = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/quant?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai";
    String username = "root";
    String password = "huliang1211";
    String serverPort = "9000";
    Configuration configuration = new Configuration();
    configuration.setDefaultEncoding(DEFAULT_CHARSET);
    configuration.setTemplateLoader(new ClassTemplateLoader(GenSpringMyBatisMvnProject.class, "/"));
    configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

    Map<Object, Object> context = new HashMap<Object, Object>();
    context.put("basePackageName", basePackageName);
    context.put("projectName", projectName);
    context.put("driverClassName", driverClassName);
    context.put("url", url);
    context.put("username", username);
    context.put("password", password);
    context.put("serverPort", serverPort);

    generateParentProject(baseDirName, basePackageName, projectName, configuration, context);
    generateApiProject(baseDirName, basePackageName, projectName, configuration, context);
    generateCoreProject(baseDirName, basePackageName, projectName, configuration, context);
    generateWebProject(baseDirName, basePackageName, projectName, configuration, context);
    generateAdminProject(baseDirName, basePackageName, projectName, configuration, context);
    generateServiceProject(baseDirName, basePackageName, projectName, configuration, context);
    generateManagerProject(baseDirName, basePackageName, projectName, configuration, context);
  }


  private static void generateParentProject(String baseDirName, String basePackageName,
      String projectName, Configuration configuration, Map<Object, Object> context)
      throws Exception {
    GenerateUtils
        .generateFile(baseDirName + "/pom.xml", "template/mvn/swmsm/pom.xml.ftl", configuration,
            context);
  }

  private static void generateApiProject(String baseDirName, String basePackageName,
      String projectName, Configuration configuration, Map<Object, Object> context)
      throws Exception {
    Map<String, String> dirMap = mkdir(baseDirName, basePackageName, projectName, "api");

    GenerateUtils
        .generateFile(dirMap.get("basedir") + "/pom.xml", "template/mvn/swmsm/api/pom.xml.ftl",
            configuration, context);
  }


  private static void generateManagerProject(String baseDirName, String basePackageName,
      String projectName, Configuration configuration, Map<Object, Object> context)
      throws Exception {
    Map<String, String> dirMap = mkdir(baseDirName, basePackageName, projectName, "manager");
    GenerateUtils
        .generateFile(dirMap.get("basedir") + "/pom.xml", "template/mvn/swmsm/manager/pom.xml.ftl",
            configuration, context);
  }


  private static void generateCoreProject(String baseDirName, String basePackageName,
      String projectName, Configuration configuration, Map<Object, Object> context)
      throws Exception {
    Map<String, String> dirMap = mkdir(baseDirName, basePackageName, projectName, "core");

    GenerateUtils
        .generateFile(dirMap.get("basedir") + "/pom.xml", "template/mvn/swmsm/core/pom.xml.ftl",
            configuration, context);

    String mainJava = dirMap.get("/src/main/java") + "/core";
    DirUtils.mkdir(mainJava + "/config");
    GenerateUtils.generateFile(mainJava + "/config/MyConfig.java",
        "template/mvn/swmsm/core/config/MyConfig.java.ftl", configuration, context);

    DirUtils.mkdir(mainJava + "/dao");
    DirUtils.mkdir(mainJava + "/dao/common");
    DirUtils.mkdir(mainJava + "/dao/system");
    GenerateUtils.generateFile(mainJava + "/dao/common/DictDao.java",
        "template/mvn/swmsm/core/dao/common/DictDao.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/dao/common/FileDao.java",
        "template/mvn/swmsm/core/dao/common/FileDao.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/dao/common/GeneratorMapper.java",
        "template/mvn/swmsm/core/dao/common/GeneratorMapper.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/dao/common/LogDao.java",
        "template/mvn/swmsm/core/dao/common/LogDao.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/dao/common/TaskDao.java",
        "template/mvn/swmsm/core/dao/common/TaskDao.java.ftl", configuration, context);

    GenerateUtils.generateFile(mainJava + "/dao/system/DeptDao.java",
        "template/mvn/swmsm/core/dao/system/DeptDao.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/dao/system/MenuDao.java",
        "template/mvn/swmsm/core/dao/system/MenuDao.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/dao/system/RoleDao.java",
        "template/mvn/swmsm/core/dao/system/RoleDao.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/dao/system/RoleMenuDao.java",
        "template/mvn/swmsm/core/dao/system/RoleMenuDao.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/dao/system/UserDao.java",
        "template/mvn/swmsm/core/dao/system/UserDao.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/dao/system/UserRoleDao.java",
        "template/mvn/swmsm/core/dao/system/UserRoleDao.java.ftl", configuration, context);

    DirUtils.mkdir(mainJava + "/entity");
    DirUtils.mkdir(mainJava + "/entity/vo");

    GenerateUtils.generateFile(mainJava + "/entity/vo/UserVO.java",
        "template/mvn/swmsm/core/entity/vo/UserVO.java.ftl", configuration, context);

    GenerateUtils.generateFile(mainJava + "/entity/ColumnDO.java",
        "template/mvn/swmsm/core/entity/ColumnDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/DeptDO.java",
        "template/mvn/swmsm/core/entity/DeptDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/DictDO.java",
        "template/mvn/swmsm/core/entity/DictDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/FileDO.java",
        "template/mvn/swmsm/core/entity/FileDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/LogDO.java",
        "template/mvn/swmsm/core/entity/LogDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/MenuDO.java",
        "template/mvn/swmsm/core/entity/MenuDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/PageDO.java",
        "template/mvn/swmsm/core/entity/PageDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/Response.java",
        "template/mvn/swmsm/core/entity/Response.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/RoleDO.java",
        "template/mvn/swmsm/core/entity/RoleDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/RoleMenuDO.java",
        "template/mvn/swmsm/core/entity/RoleMenuDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/ScheduleJob.java",
        "template/mvn/swmsm/core/entity/ScheduleJob.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/TableDO.java",
        "template/mvn/swmsm/core/entity/TableDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/TaskDO.java",
        "template/mvn/swmsm/core/entity/TaskDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/Tree.java",
        "template/mvn/swmsm/core/entity/Tree.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/UserDO.java",
        "template/mvn/swmsm/core/entity/UserDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/UserOnline.java",
        "template/mvn/swmsm/core/entity/UserOnline.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/UserRoleDO.java",
        "template/mvn/swmsm/core/entity/UserRoleDO.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/entity/UserToken.java",
        "template/mvn/swmsm/core/entity/UserToken.java.ftl", configuration, context);

    DirUtils.mkdir(mainJava + "/excel");
    GenerateUtils.generateFile(mainJava + "/excel/EasyExcelTest.java",
        "template/mvn/swmsm/core/excel/EasyExcelTest.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/excel/EasyExcelUtil.java",
        "template/mvn/swmsm/core/excel/EasyExcelUtil.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/excel/ExcelModel.java",
        "template/mvn/swmsm/core/excel/ExcelModel.java.ftl", configuration, context);

    DirUtils.mkdir(mainJava + "/util");
    GenerateUtils.generateFile(mainJava + "/util/BDException.java",
        "template/mvn/swmsm/core/util/util/BDException.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/BuildTree.java",
        "template/mvn/swmsm/core/util/util/BuildTree.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/FileType.java",
        "template/mvn/swmsm/core/util/util/FileType.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/FileUtil.java",
        "template/mvn/swmsm/core/util/util/FileUtil.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/HttpContextUtils.java",
        "template/mvn/swmsm/core/util/util/HttpContextUtils.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/HttpServletUtils.java",
        "template/mvn/swmsm/core/util/util/HttpServletUtils.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/ImageUtils.java",
        "template/mvn/swmsm/core/util/util/ImageUtils.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/IPUtils.java",
        "template/mvn/swmsm/core/util/util/IPUtils.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/Jackson.java",
        "template/mvn/swmsm/core/util/util/Jackson.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/JsonUtils.java",
        "template/mvn/swmsm/core/util/util/JsonUtils.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/JsoupUtil.java",
        "template/mvn/swmsm/core/util/util/JsoupUtil.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/MD5Utils.java",
        "template/mvn/swmsm/core/util/util/MD5Utils.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/PageUtils.java",
        "template/mvn/swmsm/core/util/util/PageUtils.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/Query.java",
        "template/mvn/swmsm/core/util/util/Query.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/R.java",
        "template/mvn/swmsm/core/util/util/R.java.ftl", configuration, context);
    GenerateUtils.generateFile(mainJava + "/util/RandomValidateCodeUtil.java",
        "template/mvn/swmsm/core/util/util/RandomValidateCodeUtil.java.ftl", configuration,
        context);
    GenerateUtils.generateFile(mainJava + "/util/ScheduleJobUtils.java",
        "template/mvn/swmsm/core/util/util/ScheduleJobUtils.java.ftl", configuration, context);

    String resources = dirMap.get("/src/main/resources");
    DirUtils.mkdir(resources + "/mybatis");
    DirUtils.mkdir(resources + "/mybatis/common");
    DirUtils.mkdir(resources + "/mybatis/system");

    GenerateUtils.generateFile(resources + "/mybatis/common" + "/DictMapper.xml",
        "template/mvn/swmsm/core/mybatis/commom/DictMapper.xml.ftl", configuration, context);
    GenerateUtils.generateFile(resources + "/mybatis/common" + "/FileMapper.xml",
        "template/mvn/swmsm/core/mybatis/commom/FileMapper.xml.ftl", configuration, context);
    GenerateUtils.generateFile(resources + "/mybatis/common" + "/LogMapper.xml",
        "template/mvn/swmsm/core/mybatis/commom/LogMapper.xml.ftl", configuration, context);
    GenerateUtils.generateFile(resources + "/mybatis/common" + "/TaskMapper.xml",
        "template/mvn/swmsm/core/mybatis/commom/TaskMapper.xml.ftl", configuration, context);

    GenerateUtils.generateFile(resources + "/mybatis/system" + "/DeptMapper.xml",
        "template/mvn/swmsm/core/mybatis/system/DeptMapper.xml.ftl", configuration, context);
    GenerateUtils.generateFile(resources + "/mybatis/system" + "/MenuMapper.xml",
        "template/mvn/swmsm/core/mybatis/system/MenuMapper.xml.ftl", configuration, context);
    GenerateUtils.generateFile(resources + "/mybatis/system" + "/RoleMapper.xml",
        "template/mvn/swmsm/core/mybatis/system/RoleMapper.xml.ftl", configuration, context);
    GenerateUtils.generateFile(resources + "/mybatis/system" + "/RoleMenuMapper.xml",
        "template/mvn/swmsm/core/mybatis/system/RoleMenuMapper.xml.ftl", configuration, context);
    GenerateUtils.generateFile(resources + "/mybatis/system" + "/UserMapper.xml",
        "template/mvn/swmsm/core/mybatis/system/UserMapper.xml.ftl", configuration, context);
    GenerateUtils.generateFile(resources + "/mybatis/system" + "/UserRoleMapper.xml",
        "template/mvn/swmsm/core/mybatis/system/UserRoleMapper.xml.ftl", configuration, context);

  }

  private static void generateWebProject(String baseDirName, String basePackageName,
      String projectName, Configuration configuration, Map<Object, Object> context)
      throws Exception {
    Map<String, String> dirMap = mkdir(baseDirName, basePackageName, projectName, "web");
    GenerateUtils
        .generateFile(dirMap.get("basedir") + "/pom.xml", "template/mvn/swmsm/web/pom.xml.ftl",
            configuration, context);
  }

  private static void generateAdminProject(String baseDirName, String basePackageName,
      String projectName, Configuration configuration, Map<Object, Object> context)
      throws Exception {
    Map<String, String> dirMap = mkdir(baseDirName, basePackageName, projectName, "admin");

    String resourcesDir = dirMap.get("/src/main/resources");
    String javaDir = dirMap.get("/src/main/java");

    List<String> list = DirUtils
        .scanFilesWithRecursion("src/main/resources/template/mvn/swmsm/admin");

    for (String path :
        list) {
      System.out.println(path);
      if (path.contains("pom.xml.ftl")) {
        GenerateUtils
            .generateFile(dirMap.get("basedir") + "/pom.xml",
                "template/mvn/swmsm/admin/pom.xml.ftl",
                configuration, context);
      } else if (path.contains(".java.ftl")) {
        String templateDir = path
            .replace("/Users/didi/workSpace/buildProjectTool/src/main/resources/", "");
        path = path.replace(
            "/Users/didi/workSpace/buildProjectTool/src/main/resources/template/mvn/swmsm/admin",
            "");
        path = path.replace(".ftl", "");
        String aimDir = javaDir + path;
        String aimPath = aimDir.substring(0, aimDir.lastIndexOf("/"));
        File file = new File(aimPath);
        if (!file.exists()) {
          DirUtils.mkdir(aimPath);
        }
        GenerateUtils.generateFile(aimDir, templateDir, configuration, context);
      } else if (path.contains(".yml.ftl") || path.contains(".xml.ftl")) {
        String templateDir = path
            .replace("/Users/didi/workSpace/buildProjectTool/src/main/resources/", "");
        path = path.replace(
            "/Users/didi/workSpace/buildProjectTool/src/main/resources/template/mvn/swmsm/admin",
            "");
        path = path.replace(".ftl", "");
        String aimDir = resourcesDir + path;
        GenerateUtils.generateFile(aimDir, templateDir, configuration, context);
      } else {
        System.out.println(path);
        String begindir = path;
        String templateDir = path
            .replace("/Users/didi/workSpace/buildProjectTool/src/main/resources/", "");
        path = path.replace(
            "/Users/didi/workSpace/buildProjectTool/src/main/resources/template/mvn/swmsm/admin",
            "");
        path = path.replace(".ftl", "");
        path = path.replace("/resources", "");
        String aimDir = resourcesDir + path;
        String aimPath = aimDir.substring(0, aimDir.lastIndexOf("/"));
        File file = new File(aimPath);
        if (!file.exists()) {
          DirUtils.mkdir(aimPath);
        }
        DirUtils.copyNio(begindir, aimDir);
      }
    }


  }

  private static void generateServiceProject(String baseDirName, String basePackageName,
      String projectName, Configuration configuration, Map<Object, Object> context)
      throws Exception {
    Map<String, String> dirMap = mkdir(baseDirName, basePackageName, projectName, "service");

    List<String> list = DirUtils
        .scanFilesWithRecursion("src/main/resources/template/mvn/swmsm/service");
    String resourcesDir = dirMap.get("/src/main/java");

    for (String path :
        list) {
      System.out.println(path);
      if (path.contains("pom.xml.ftl")) {
        GenerateUtils
            .generateFile(dirMap.get("basedir") + "/pom.xml",
                "template/mvn/swmsm/service/pom.xml.ftl",
                configuration, context);
      } else if (path.contains(".java.ftl")) {
        String templateDir = path
            .replace("/Users/didi/workSpace/buildProjectTool/src/main/resources/", "");
        path = path.replace(
            "/Users/didi/workSpace/buildProjectTool/src/main/resources/template/mvn/swmsm/service",
            "");
        path = path.replace(".ftl", "");
        String aimDir = resourcesDir + path;
        String aimPath = aimDir.substring(0, aimDir.lastIndexOf("/"));
        File file = new File(aimPath);
        if (!file.exists()) {
          DirUtils.mkdir(aimPath);
        }
        GenerateUtils.generateFile(aimDir,
            templateDir, configuration, context);
      } else {

      }
    }
  }


  private static Map<String, String> mkdir(String baseDirName, String basePackageName,
      String projectName, String subProjectSuffix) {
    Map<String, String> dirMap = new HashMap<String, String>();

    String subProjectBaseDirName = baseDirName + "/" + projectName + "-" + subProjectSuffix;
    DirUtils.mkdir(subProjectBaseDirName);
    dirMap.put("basedir", subProjectBaseDirName);

    String subPackageName = "core".equals(subProjectSuffix) ? "" : ("/" + subProjectSuffix);

    String dirName =
        subProjectBaseDirName + "/src/main/java/" + basePackageName.replace('.', '/') + "/"
            + projectName + subPackageName;
    DirUtils.mkdir(dirName);
    dirMap.put("/src/main/java", dirName);

    dirName = subProjectBaseDirName + "/src/main/resources";
    DirUtils.mkdir(dirName);
    dirMap.put("/src/main/resources", dirName);

    dirName = subProjectBaseDirName + "/src/test/java/" + basePackageName.replace('.', '/') + "/"
        + projectName + subPackageName;
    DirUtils.mkdir(dirName);
    dirMap.put("/src/test/java", dirName);

    dirName = subProjectBaseDirName + "/src/test/resources";
    DirUtils.mkdir(dirName);
    dirMap.put("/src/test/resources", dirName);

    return dirMap;
  }
}
