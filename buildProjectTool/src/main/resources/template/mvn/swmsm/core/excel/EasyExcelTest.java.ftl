package ${basePackageName}.${projectName}.core.excel;

import com.alibaba.excel.support.ExcelTypeEnum;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

public class EasyExcelTest {

public static final String path = "test.xlsx";

public static void main(String[] args) throws Exception {
//     writeExcel();
readExcel();
}

/**
* 写入Excel
*
* @throws FileNotFoundException
* @author Lynch
*/

private static void writeExcel() throws FileNotFoundException {
List
<ExcelModel> excelModelList = new ArrayList<>();
    for (int i = 0; i < 10; i++) {
    ExcelModel excelModel = new ExcelModel();
    excelModel.setId("id" + i);
    excelModel.setName("姓名" + i);
    excelModel.setCollection1("collection" + i);
    excelModel.setShhe("sshe" + i);
    excelModelList.add(excelModel);
    }

    long beginTime = System.currentTimeMillis();
    OutputStream out = new FileOutputStream(path);
    EasyExcelUtil.writeExcelWithModel(out, excelModelList, ExcelModel.class, ExcelTypeEnum.XLSX);
    long endTime = System.currentTimeMillis();
    System.out.println(String.format("总共耗时 %s 毫秒", (endTime - beginTime)));
    excelModelList = null;
    }


    /**
    * 读取Excel
    *
    * @author Lynch
    */

    private static void readExcel() {
    try {
    InputStream inputStream = new FileInputStream(path);
    InputStream is = new BufferedInputStream(inputStream);
    //读入文件，每一行对应一个 Model，获取 Model 列表
    List
    <ExcelModel> objectList = EasyExcelUtil
        .readExcelWithModel(is, ExcelModel.class);
        for (ExcelModel excelModel : objectList) {
        System.out.println(excelModel);
        }
        } catch (IOException e) {
        e.printStackTrace();
        }

        }

        }
