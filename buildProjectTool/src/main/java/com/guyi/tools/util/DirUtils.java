package com.guyi.tools.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.channels.FileChannel;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

public final class DirUtils {


  public static void copyNio(String source, String dest) throws IOException {
    FileChannel input = null;
    FileChannel output = null;

    try {
      input = new FileInputStream(new File(source)).getChannel();
      output = new FileOutputStream(new File(dest)).getChannel();
      output.transferFrom(input, 0, input.size());
    } catch (Exception e) {
    } finally {

      if (input != null) {
        input.close();
      }
      if (output != null) {
        output.close();
      }
    }
  }

  private static void copyFileUsingJava7Files(File source, File dest)  {
    try {
      Files.copy(source.toPath(), dest.toPath());
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public static void mkdir(String dirName) {
    File dir = new File(dirName);
    dir.mkdirs();

    System.out.println("mkdir: " + dirName);
  }

  private DirUtils() {
  }

  public static void main(String[] args) {
    List<String> list=scanFilesWithRecursion("/Users/didi/workSpace/buildProjectTool/src/main/resources/template/mvn/swmsm/admin");
    System.out.println(list);
  }

  public static ArrayList<String> scanFilesWithRecursion(
      String folderPath) {
    ArrayList<String> dirctorys = new ArrayList<String>();
    ArrayList<String> scanFiles = new ArrayList<String>();
    return scanFilesWithRecursion(dirctorys,scanFiles,folderPath);
  }
  public static ArrayList<String> scanFilesWithRecursion(
      ArrayList<String> dirctorys, ArrayList<String> scanFiles,
      String folderPath) {
    File directory = new File(folderPath);
    if (!directory.isDirectory()) {
      throw new RuntimeException('"' + folderPath + '"'
          + " input path is not a Directory , please input the right path of the Directory. ^_^...^_^");
    }
    if (directory.isDirectory()) {
      File[] filelist = directory.listFiles();
      for (int i = 0; i < filelist.length; i++) {
        /**如果当前是文件夹，进入递归扫描文件夹**/
        if (filelist[i].isDirectory()) {
          dirctorys.add(filelist[i].getAbsolutePath());
          /**递归扫描下面的文件夹**/
          scanFilesWithRecursion(dirctorys, scanFiles, filelist[i].getAbsolutePath());
        }
        /**非文件夹**/
        else {
          scanFiles.add(filelist[i].getAbsolutePath());
        }
      }
    }
    return scanFiles;
  }

}
