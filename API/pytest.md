# 创建测试文件
创建名为test_*.py的文件，*为任意字符，如test_demo.py。前缀test_是固定表达。

# 创建测试类
创建名为Test*的类，*为任意字符，如TestDemo。前缀Test是固定表达。

# 创建测试方法
创建名为test_*的方法，*为任意字符，如test_demo。前缀test_是固定表达。

# 执行测试
## 执行所有测试
cd到测试文件所在目录，执行pytest命令，会自动查找当前目录下所有test_*.py文件，执行所有测试。
## 执行指定测试
pytest -k "test_demo"，执行类或方法名称里包含"test_demo"的所有测试。test_demo既可以是类名，也可以是方法名。
