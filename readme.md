author: YZY, Tsinghua, School of Integrated Circuits

first edit @ 2022-10-30

csv2xlsx_batch适用于将B1500测试生成的csv文件批量转成formated xlsx文件；

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

-------------------------------------------------------------------------

# update for appended mode file @ 2022-12-04

-------------------------------------------------------------------------

csv2xlsx_batch_invx适用于append测试模式生成的数据块文件，各个数据块之间指定'appvar'进行标记区分
其余1500测试条件应该相同；

生成的xlsx文件将appvar作为dim2，同一块内的不同观测变量作为sheet维度导出；

-------------------------------------------------------------------------

# update for single-block file @ 2022-12-05

-------------------------------------------------------------------------

csv2xlsx_batch_single_block适用于只有单个数据块的数据文件；

不过，相比于csv2xlsx_batch，它没有整理功能，单纯起到删除csv头文件的作用；

原理是先读入变量名列和数据块，然后再写入到同名xlsx文件里；


-------------------------------------------------------------------------

# update for multi ports and multi vddx file @ 2023-01-11 

-------------------------------------------------------------------------

脚本：csv2xlsx_batch_invx_vddx.m适用于xlsx文件里append了多个port的INV测试数据，且每个port还扫描了多组vdd参数

fliptag=0，当csv端口排列顺序与指定的端口顺序一致时
fliptag=1，当csv端口排列顺序与指定的端口顺序相反时

不同vdd测试的数据块，放在对应后缀的xlsx文件里；
每个xlsx文件里，并行测试的变量分列不同sheet；
每个sheet，列出不同端口的变量值；