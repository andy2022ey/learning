# pyplot模块
## figure
激活或创建Figure对象。Figure对象是一个顶层容器，类似于画布。
```python
figure(num=None, figsize=None, dpi=None, facecolor=None, edgecolor=None, frameon=True, FigureClass=<class 'matplotlib.figure.Figure'>, clear=False)
- num：图像编号或名称，数字为编号，字符串为名称。
- figsize：指定figure的宽和高，单位为英寸。
- dpi：分辨率，默认是100。分别率越高，绘制越慢。
- facecolor：画布背景颜色，颜色名称或者RGB颜色代码，'lightgrey', 'yellow', 'lightblue'等。这个属性不会影响图像背景颜色，只会影响图像四周的颜色。
- clear：是否清空当前图像。
```
一般情况下，我们不需要显示调用figure()函数，matplotlib会自动创建。只有当需要绘制多张图时，才需要显示调用该函数。属性设置只有在初次创建figure对象时才有效，之后再激活Figure对象时设置属性不会生效。

## scatter
绘制散点图。
```python
scatter(x, y, s=None, c=None, marker=None, cmap=None, norm=None, vmin=None, vmax=None, alpha=None, linewidths=None, verts=None, edgecolors=None, *, plotnonfinite=False, data=None, **kwargs)
- x：x轴数据。
- y：y轴数据。
- s：散点的大小。
- c：散点的颜色。
- marker：散点的形状。
- cmap：散点的颜色映射。
- norm：归一化。
- vmin：最小值。
- vmax：最大值。
- alpha：散点的透明度。
- linewidths：线宽。
- verts：顶点。
- edgecolors：散点边界的颜色。
- plotnonfinite：是否绘制无穷值。
- data：数据来源。
```

## plot
绘制线性图形。
```python
plot(*args, linestyle=None, linewidth=None, color=None, marker=None, markersize=None，label=None，scalex=True, scaley=True, data=None)
- *args：x,y，可选，必须是可迭代对象。
- linestyle：曲线的线型，可选。实线："-",虚线：'--'，点线：":"。
- linewidth：曲线的线宽，可选。默认1.5。
- color：曲线的颜色，可选。红色：'red'，灰色：'0.75'。
- marker：构成曲线的点的形状，可选。圆点：'o'，方块：'s'，三角形："^"。
- markersize：曲线标记的大小，可选。
- label：曲线标签，可选。
- scalex：是否自动缩放x轴，可选。
- scaley：是否自动缩放y轴，可选。
- data：数据来源，可选。可以是字典，DataFrame或者结构化或记录数组。
-matplotlib默认不加载中文字体，所以无法显示中文。可以通过以下代码解决：
# 设置全局字体
plt.rcParams['font.family'] = 'STKaiti'
有效的中文字体有：STSong、STKaiti、STFangsong、STXihei、Microsoft YaHei。
```
## FontProperties
单独设置字体属性。
```python
from matplotlib.font_manager import FontProperties
font_path = '/path/to/your/font.ttf'
font_prop = FontProperties(fname=font_path)
plt.xlabel('x轴', fontproperties=font_prop)
plt.ylabel('y轴', fontproperties=font_prop)
plt.title('标题', fontproperties=font_prop)
```
## legend
显示曲线的标签，设置标签样式、位置。
```python
legend(fontsize=11)
- fontsize：标签字体大小。
```

## xlabel, ylabel, title
设置x轴标签, y轴标签, 图像标题。
```python
xlabel(xlabel, fontdict=None, fontproperties=None, labelpad=None, **kwargs)
ylabel(ylabel, fontdict=None, fontproperties=None, labelpad=None, **kwargs)
title(label, fontdict=None, loc='center', pad=None, **kwargs)
- fontdict：字体属性，可选。一个字体属性字典。键值对的形式，如：{family:'serif','size': 14, 'color': 'blue'}。
- fontproperties：字体属性，可选。
- labelpad：标签与轴的距离，可选。
- loc：标题位置，可选。'left', 'center', 'right'。
- pad：标题与轴的距离，可选。
```

## text
在图像中添加文本。
```python
text(x, y, s, fontdict=None, withdash=False, **kwargs)
- x：文本位置的x坐标。
- y：文本位置的y坐标。
- s：文本内容,支持LaTeX语法。
- fontdict：字体属性，可选。
- withdash：是否使用虚线。
```

## xlim, ylim
设置x轴和y轴的显示范围。
```python
xlim(left=None, right=None, emit=True, auto=False, *, xmin=None, xmax=None)
ylim(bottom=None, top=None, emit=True, auto=False, *, ymin=None, ymax=None)
- left：x轴的最小值。
- right：x轴的最大值。
- bottom：y轴的最小值。
- top：y轴的最大值。
- emit：是否触发事件。
- auto：是否自动缩放。
```
## xticks, yticks
设置x轴和y轴的刻度。
```python
xticks(ticks=None, labels=None, **kwargs)
yticks(ticks=None, labels=None, **kwargs)
- ticks：刻度值。
- labels：刻度标签。
```

## subplots
创建一个新的Figure对象，和Axes对象或Axes对象列表。Axes是Figure对象中的子图，默认只有一个子图。
子图拥有pyplot中的所有方法，可以通过Axes对象调用。
```python
fig, axs = subplots(nrows=1, ncols=1, sharex=False, sharey=False, squeeze=True, subplot_kw=None, gridspec_kw=None, dpi=100, **fig_kw)
- nrows：子图的行数。
- ncols：子图的列数。
- sharex：是否共享x轴。
- sharey：是否共享y轴。
- squeeze：是否压缩子图。
- subplot_kw：Axes对象的关键字参数。
- gridspec_kw：GridSpec对象的关键字参数。
- fig_kw：Figure对象的关键字参数。
- dpi：分辨率。fig_kw的参数之一。
```
## Axes对象
### spines
设置坐标轴。
```python
"""实现坐标轴在图像中心的效果"""
# 将坐标轴放到图像中心，刻度也会跟着移动
ax.spines['left'].set_position('center')
ax.spines['bottom'].set_position('center')
# 隐藏坐标轴
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')
```
### plot
绘制折线图，参数同plot函数。
### xaixs, yaixs：设置x轴和y轴属性。
#### set_ticks_position，设置刻度线的位置。
```python
ax.xaxis.set_ticks_position('bottom')
ax.yaxis.set_ticks_position('left')
```

## set_facecolor
对Figure对象设置坐标轴背景颜色。




