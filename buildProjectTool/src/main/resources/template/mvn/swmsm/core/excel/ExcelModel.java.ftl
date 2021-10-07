package ${basePackageName}.${projectName}.core.excel;


import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.metadata.BaseRowModel;
import java.io.Serializable;
import lombok.Data;

@Data
public class ExcelModel extends BaseRowModel implements Serializable {

@ExcelProperty(value = "指标ID", index = 0)
private String id;


@ExcelProperty(value = "指标名称", index = 1)
private String name;


@ExcelProperty(value = "指标功能集", index = 2)
private String collection1;


@ExcelProperty(value = "计算公式", index = 3)
private String shhe;


}
