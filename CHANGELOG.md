## 0.4.3+1

* 增加PlatformException收集时分离错误及堆栈信息;

## 0.4.3

* 整合代码,简化调用

## 0.4.2

* 修复分析数据库创建的bug
* 替换crash收集数据库为hive

## 0.4.1+2

* 修复`AnalysisDatabase.init()`中创建`analysis`数据库的bug.

## 0.4.1+1

* 修改日志上传时机

## 0.4.1

* 增加崩溃日志的记录与上传

## 0.4.0

* 基础logger功能
* overlay widget
    * Toast
    * Loading

## 0.3.0

* 重构项目

## 0.2.0

* 使用`Provider`管理状态.
* 使用`shared_preferences`管理缓存.

## 0.1.2

* yuro_route update.

## 0.1.1

* 修复YuroStorage针对Yuro的扩展函数的初始化问题，现在需要在runApp()前手动调用`await Yuro.initStorage()`完成初始化.

## 0.1.0

* Yuro开发套件初版

## 0.0.3

* 增加event_bus支持

## 0.0.2

* 增加toHex]和toUint8List]扩展函数

## 0.0.1

* first commit.