# 函数
- 函数返回值：如果函数没有显式地return语句，那么它会隐式地返回None

# configparser模块
- 如果ini文件中的option只有键没有值，那么读取出来的值为空字符串，而不是None

# __file__
__file__是当前文件的路径。即使当前文件被其他文件import，__file__也依然能在调用它的文件中正常工作。

# 字典
- 字典的键可以是空字符串，空字符串作为键，可以正常使用get方法获取值。

# @property
当被property装饰的方法出错，会抛出AttributeError异常，而不是TypeError异常。
xxx object has no attribute 'myfunc' 
