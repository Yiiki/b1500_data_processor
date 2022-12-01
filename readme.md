author: YZY, Tsinghua, School of Integrated Circuits, 2022-10-30

适用于将B1500测试生成的csv文件转成formated xlsx文件；

特别是FET测试产生的矩阵数据；

导出的xlsx文件包括：矩阵数据块，以及变量名称行

## 使用方式：

    1.将csv文件拷贝到data文件夹下；

    2.运行"csv2xlsx_batch.m"；

    3.date_export文件夹下将产生对应xlsx文件；

## 注意事项：

1.确保顶层文件夹"tool_csv2xlsx"及其子文件夹都在MATLAB路径下；

2.每次运行，"csv2xlsx_batch.m"都会将data文件夹下的所有csv文件进行转换；

3.如果csv文件不完整（例如测试中途取消，导致约定的测试点没有采集完全），则脚本将会跳过该csv文件，不会产生对应的输出文件；

4.目前版本只适用于仅包含一个"DataName"的csv文件；包含多个"DataName"的csv文件可能是由于测试时选择了append模式导致；

5.运行主程序时请确保MATLAB路径位于顶层文件夹``tool_csv2xlsx``，否则程序中的相对路径会找不到数据；