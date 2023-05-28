# linspace
创建并返回一维数组array对象（等差数列）。
numpy.linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None, axis=0)
endpoint：数列结尾是否包含stop值。
retstep：如果为True，返回值为(数组, 步长)。
dtype：返回数组的数据类型。
axis：指定数组的维度。若为1，则返回一个行向量。

# logspace
创建并返回一维数组array对象（等比数列）。
numpy.logspace(start, stop, num=50, endpoint=True, base=10.0, dtype=None, axis=0)
base：对数的底数。
其他参数同linspace。

# arange