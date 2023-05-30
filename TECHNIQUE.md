pyqt技术：
# 1. pyqt的源码是c++写的。pyqt模块使用SIP工具生成python模块，因此在python模块中的源码中，函数下面都是pass,没有函数体。现有的pyqt或pyside文档中的内容是不完整的，很多函数是缺失的。要看真正的源码需要去c++源码中看。想要做出灵活高级的功能，必须要学会重构pyqt源码，想要重构pyqt源码，必须要学会c++，所以pyqt的学习成本很高。
# 2. 动态属性
动态属性的主要作用是允许开发人员在不修改对象类定义的情况下，为对象添加额外的属性和行为。这对于在运行时动态地管理对象的状态和元数据非常有用，例如在 GUI 应用程序中为控件添加自定义属性、标记或标签等。
```python
image = QImage('image.jpg')
image.setProperty('author', 'John Doe')
image.setProperty('capture_date', '2022-05-08')
image.setProperty('copyright', 'Copyright (c) 2022 John Doe')

label = QLabel()
label.setPixmap(QPixmap.fromImage(image))
label.setText(f'Author: {image.property("author")}\n'
              f'Capture date: {image.property("capture_date")}\n'
              f'Copyright: {image.property("copyright")}')
```
3.`gencache.EnsureDispatch`, `Dispatch`, 和 `DispatchEx` 都是 Python 的 `win32com.client` 模块中用于与 COM（Component Object Model）对象进行交互的方法。在 Windows 操作系统中，COM 是一种跨语言的组件模型，允许不同的应用程序和组件相互通信。这三个方法有一些区别，如下所述：
gencache.EnsureDispatch (prog_id)：
`gencache.EnsureDispatch` 是一个辅助函数，它确保对应于给定的程序 ID (prog_id) 的 COM 对象的缓存生成。如果缓存已经存在，它将使用缓存的对象。否则，它将生成缓存并返回。这个方法可以提高与 COM 对象的交互速度，因为它避免了重复创建 COM 对象。
Dispatch (prog_id)：
`Dispatch` 函数用于创建一个 COM 对象，通过提供一个程序 ID (prog_id)。这个方法创建一个晚期绑定的 COM 对象，这意味着它在运行时检查对象方法和属性。这可能会导致运行速度较慢，但在某些情况下，这种灵活性是必要的。`Dispatch` 是 `win32com.client` 模块中最常用的方法之一。
DispatchEx (prog_id)：
`DispatchEx` 类似于 `Dispatch`，但它还允许您指定一个附加的 `CLSCTX` 值。`CLSCTX` 值是一组标志，用于指示如何创建 COM 对象。例如，可以使用 `CLSCTX` 值指定在本地或远程服务器上创建对象。这个方法主要用于在特定的上下文环境中创建 COM 对象。
- `gencache.EnsureDispatch` 用于确保已生成缓存的 COM 对象，并在可能的情况下提高性能。
- `Dispatch` 创建一个晚期绑定的 COM 对象，适用于大多数场景。
- `DispatchEx` 类似于 `Dispatch`，但允许您指定 COM 对象创建的上下文环境。
在大多数情况下，你可以使用 `gencache.EnsureDispatch` 或 `Dispatch`，具体取决于你是否需要生成缓存来提高性能。只有在需要特定的上下文环境时，才需要使用 `DispatchEx`。
# 4.@property 是一个装饰器，它允许将类的方法作为属性访问.
- 使用 @property 装饰器的方法不应该接受除 self 之外的任何参数。如果你需要在类中定义一个需要参数的属性，你应该考虑使用普通的方法。
- 使用 @property 装饰器的另一个优点是，你可以轻松地为这些属性添加 “setter” 方法，以控制如何设置属性的值。为此，你可以使用 @<attribute>.setter 装饰器。例如：
```python
class Circle:
    @property
    def radius(self):
        return self._radius
    @radius.setter
    def radius(self, value):
        if value < 0:
            raise ValueError("Radius cannot be negative")
        self._radius = value
```
这样做的好处一是将属性的设置和获取分离开来，二是可以在设置属性时添加一些额外的逻辑。
# 5.__new__ 是一个特殊的 Python 方法，它用于创建类的新实例。当创建一个类的对象时，首先会调用 __new__ 方法，然后调用 __init__ 方法。通常，我们重写 __init__ 方法以自定义对象的初始化，但在某些情况下，我们可能需要重写 __new__ 以控制对象的创建过程。
- def __new__(cls, pt):
    return float.__new__(cls, pt)
在这个示例中，__new__ 方法调用了 float 类的 __new__ 方法，将 cls 和 pt 作为参数。这意味着这个类将创建一个新的 float 类型实例。在这种情况下，重写 __new__ 方法的目的是使这个类继承自 float 类，从而使创建的对象具有 float 类的所有属性和方法。
此代码示例适用于 Pt 类（如前面的回答所示），它是一个表示长度（以点为单位）的类。Pt 类通过继承 float 类来具有与浮点数相同的功能。在这个例子中，重写 __new__ 方法允许我们创建一个新的 float 类型实例，并将其与 Pt 类相关联。这样，Pt 类可以像浮点数一样使用，同时还可以添加自定义属性和方法，例如将点值转换为其他度量单位。

# 6python特殊方法
在 Python 中，特殊方法是一组以双下划线开始和结束的方法，它们用于实现类的某些特定行为。以下是一些常用的特殊方法及其用途：
__init__(self, ...): 对象初始化方法。在创建新对象时，__init__ 方法会被自动调用以初始化对象的状态。
__str__(self): 定义对象的字符串表示。当使用 print() 函数或将对象转换为字符串（str(obj)）时，会调用此方法。
__repr__(self): 定义对象的“正式”字符串表示。在交互式解释器中直接输入对象名称时，会显示此方法的返回值。
__eq__(self, other): 定义对象的等于运算符（==）。当使用 == 运算符比较两个对象时，会调用此方法。
__ne__(self, other): 定义对象的不等于运算符（!=）。当使用 != 运算符比较两个对象时，会调用此方法。
__lt__(self, other): 定义对象的小于运算符（<）。当使用 < 运算符比较两个对象时，会调用此方法。
__le__(self, other): 定义对象的小于等于运算符（<=）。当使用 <= 运算符比较两个对象时，会调用此方法。
__gt__(self, other): 定义对象的大于运算符（>）。当使用 > 运算符比较两个对象时，会调用此方法。
__ge__(self, other): 定义对象的大于等于运算符（>=）。当使用 >= 运算符比较两个对象时，会调用此方法。
__add__(self, other): 定义对象的加法运算符（+）。当使用 + 运算符将两个对象相加时，会调用此方法。
__sub__(self, other): 定义对象的减法运算符（-）。当使用 - 运算符将两个对象相减时，会调用此方法。
__mul__(self, other): 定义对象的乘法运算符（*）。当使用 * 运算符将两个对象相乘时，会调用此方法。
__truediv__(self, other): 定义对象的除法运算符（/）。当使用 / 运算符将两个对象相除时，会调用此方法。
__floordiv__(self, other): 定义对象的整除运算符（//）。当使用 // 运算符将两个对象整除时，会调用此方法。
__mod__(self, other): 定义对象的取模运算符（%）。当使用 % 运算符计算两个对象的余数时，会调用此方法。
__pow__(self, other): 定义对象的乘方运算符（**）。当使用 ** 运算符计算一个对象的乘方时，会调用此方法。
__getitem__(self, key): 定义使用索引运算符（[]）访问对象元素的方法。当使用 obj[key] 访问对象的元素时，会调用此方法。
__setitem__(self, key, value): 定义使用索引运算符（[]）设置对象元素值的方法。当使用 obj[key] = value 设置对象的元素值时，会调用此方法。
__delitem__(self, key): 定义使用索引运算符（[]）删除对象元素的方法。当使用 del obj[key] 删除对象的元素时，会调用此方法。
__len__(self): 定义对象的长度。当使用 len(obj) 函数获取对象的长度时，会调用此方法。
__contains__(self, item): 定义对象的成员测试运算符（in）。当使用 item in obj 检查对象是否包含某个元素时，会调用此方法。
__iter__(self): 定义对象的迭代器。当在 for 循环中遍历对象时，会调用此方法。
__enter__(self): 定义上下文管理器的 __enter__ 方法。当使用 with 语句创建一个上下文管理器时，会调用此方法。
__exit__(self, exc_type, exc_val, exc_tb): 定义上下文管理器的 __exit__ 方法。当 with 语句块执行完成后，会调用此方法。
__call__(self, ...)：定义对象的“可调用”行为。当将对象当作函数调用时（如 obj(args)），会调用此方法。
这些特殊方法只是 Python 中众多特殊方法的一部分。你可以在 Python 文档的 数据模型 部分了解更多关于特殊方法的信息。了解这些特殊方法可以帮助你更好地理解 Python 对象的行为，并创建自定义类以满足特定需求。
# 7生成器和迭代器
迭代器是一个可以遍历数据集合的对象。在Python中，任何实现了__iter__()和__next__()方法的对象都是迭代器。__iter__()方法返回迭代器对象本身，__next__()方法返回下一个数据项，当数据集合遍历完毕时，抛出StopIteration异常。
```python
my_list = [1, 2, 3, 4, 5]
my_iter = iter(my_list)
while True:
    try:
        item = next(my_iter)
        print(item)
    except StopIteration:
        break
```
使用iter()函数将my_list转换为迭代器，并使用next()函数逐个获取列表中的数据项。当数据集合遍历完毕时，抛出StopIteration异常并退出循环
生成器是一种特殊的迭代器，它可以在运行时生成数据项，而不是一次性生成所有数据项。
在Python中，生成器可以使用函数或生成器表达式来创建。生成器函数是一种包含yield语句的函数，当函数执行到yield语句时，生成器会返回一个数据项，并暂停函数的执行，等待下一次调用。生成器表达式类似于列表推导式，但是返回一个生成器对象，将列表推导式的中括号替换成圆括号就是生成器表达式。
```python
# 使用生成器函数创建生成器
def my_generator():
    for i in range(1, 6):
        yield i
# 使用生成器表达式创建生成器
my_gen = (i for i in range(1, 6))
```
# 8.pywin32缓存错误的处理
```python
import sys
import shutil
import pythoncom
from win32com.client import gencache
def EnsureDispatchEx(clsid, new_instance=True):
    """Create a new COM instance and ensure cache is built,
       unset read-only gencache flag"""
    if new_instance:
        clsid = pythoncom.CoCreateInstanceEx(clsid, None, pythoncom.CLSCTX_SERVER,
                                             None, (pythoncom.IID_IDispatch,))[0]
    if gencache.is_readonly:
        #fix for "freezed" app: py2exe.org/index.cgi/UsingEnsureDispatch
        gencache.is_readonly = False
        gencache.Rebuild()
    try:
        return gencache.EnsureDispatch(clsid)
    except (KeyError, AttributeError):  # no attribute 'CLSIDToClassMap'
        # something went wrong, reset cache
        shutil.rmtree(gencache.GetGeneratePath())
        for i in [i for i in sys.modules if i.startswith("win32com.gen_py.")]:
            del sys.modules[i]
        return gencache.EnsureDispatch(clsid)
wdApp = EnsureDispatchEx("Word.Application")
```
# logging模块
```python
# 配置日志记录器
import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s',)
# 记录日志,默认输出到控制台
logging.debug('这是一个debug级别的日志')
logging.info('这是一个info级别的日志')
logging.warning('这是一个warning级别的日志')
logging.error('这是一个error级别的日志')
logging.critical('这是一个critical级别的日志')
```
DEBUG：调试级别的日志记录，通常用于调试程序时输出一些调试信息；
INFO：普通信息级别的日志记录，通常用于输出程序运行过程中的一些重要信息；
WARNING：警告级别的日志记录，表示程序遇到了一些非致命性的问题或警告，但程序仍然可以正常运行；
ERROR：错误级别的日志记录，表示程序遇到了一些错误，但程序仍然可以继续运行；
CRITICAL：严重错误级别的日志记录，表示程序遇到了一些严重的问题，程序可能无法继续运行；
NOTSET：未设置日志级别，表示不对日志进行过滤，将所有日志都记录下来。

配置日志记录器的作用有以下几个方面：
指定日志记录的级别：日志记录器可以设置不同的日志记录级别，以便在不同的情况下记录不同级别的日志信息。例如，可以设置为DEBUG级别来记录程序的详细运行信息，或设置为ERROR级别来记录程序的错误信息。
指定日志记录的格式：日志记录器可以设置不同的日志记录格式，以便将日志记录输出到不同的目标，并满足不同的需求。例如，可以设置为简单的文本格式，也可以设置为JSON、XML等格式。
指定日志记录的目标：日志记录器可以设置不同的日志记录目标，以便将日志记录输出到不同的地方，例如控制台、文件、网络等。

# 运算符优先级
`&`是位运算符，优先级高于`==`;`and`是逻辑运算符，优先级低于`==`.

# 工厂函数的创建类型
简单工厂模式（Simple Factory Pattern）：使用一个工厂函数来创建不同类型的对象，根据传入的参数或条件来确定创建哪种类型的对象。这种模式通常用于创建对象的逻辑比较简单的情况。

工厂方法模式（Factory Method Pattern）：定义一个抽象的工厂接口和一组具体的工厂类，每个具体工厂类负责创建一种具体类型的对象。这种模式通常用于需要创建多个相似但不完全相同类型的对象的情况。

抽象工厂模式（Abstract Factory Pattern）：定义一个抽象的工厂接口和一组具体的工厂类，每个具体工厂类负责创建一组相关的对象，这些对象之间存在某种关联关系。这种模式通常用于需要创建一组相关对象的情况，例如创建不同风格的 GUI 组件。

单例模式（Singleton Pattern）：使用一个工厂函数来创建唯一的对象实例，确保该实例在整个应用程序中只存在一个。这种模式通常用于需要全局访问一个唯一实例的情况。

原型模式（Prototype Pattern）：使用一个工厂函数来创建新的对象实例，该实例是从现有对象复制而来。这种模式通常用于需要创建多个相似但不完全相同类型的对象的情况，但是每个对象的创建成本很高。

建造者模式（Builder Pattern）：使用一个工厂函数来创建一个复杂对象，该对象由多个部分组成，每个部分都需要按照一定的顺序创建。这种模式通常用于需要创建具有复杂内部结构的对象的情况，例如创建一个包含多个组件的汽车。

# excel单元格填充颜色
python无法识别excel主题色。设置主题色之后，点击填充颜色下拉按钮，点击其他颜色，点击确定，即可将主题颜色转换为python能识别的普通RGB颜色

# PC端海外环境
在pc端搭建一个国外的网络环境步骤如下：1、首先，你需要准备一个国外的VPN，可以通过各种VPN服务提供商购买；2、安装VPN客户端软件，并配置服务器地址及登录凭据；3、配置操作系统的网络代理，使用VPN服务器的IP地址和端口号；4、设置DNS服务器为国外服务器，如Google DNS；5、最后，启动VPN，这样就可以在PC端搭建一个国外的网络环境了。