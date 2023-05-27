# 自定义QtreeView

## 1.自定义数据模型
```python
class CustomNode:
   def __init__(self, data, parent=None):
       self._data = data
       self._parent = parent
       self._children = []

       if parent is not None:
           parent.addChild(self)

   def addChild(self, child):
       self._children.append(child)

   def child(self, row):
       return self._children[row]

   def childCount(self):
       return len(self._children)

   def columnCount(self):
       return len(self._data)

   def data(self, column):
       try:
           return self._data[column]
       except IndexError:
           return None

   def parent(self):
       return self._parent

   def row(self):
       if self._parent is not None:
           return self._parent._children.index(self)

       return 0
```
## 2.自定义数据model
```python
class CustomModel(QAbstractItemModel):
    def __init__(self, root, parent=None):
        super(CustomModel, self).__init__(parent)
        self._rootNode = root

    def rowCount(self, parent=QModelIndex()):
        # 必须实现的方法，返回给定父索引下的行数
        if not parent.isValid():  # isValid是QModelIndex类的一个方法，用于检查索引是否有效
            parentNode = self._rootNode
        else:
            parentNode = parent.internalPointer()

        return parentNode.childCount()

    def columnCount(self, parent=QModelIndex()):
        # 必须实现的方法，返回给定父索引下的列数
        if not parent.isValid():
            parentNode = self._rootNode
        else:
            parentNode = parent.internalPointer()

        return parentNode.columnCount()

    def data(self, index, role):
        # 必须实现的方法，返回给定索引和项下的数据
        if not index.isValid():
            return None

        node = index.internalPointer()

        if role == Qt.DisplayRole or role == Qt.ItemDataRole.EditRole:
            return node.data(index.column())

        return None

    def parent(self, index):
        # 必须实现的方法，返回给定索引的父索引QModelIndex对象
        node = self.getNode(index)
        parentNode = node.parent()

        if parentNode == self._rootNode:
            return QModelIndex()

        return self.createIndex(parentNode.row(), 0, parentNode)

    def index(self, row, column, parent=QModelIndex()):
        # 必须实现的方法，根据给定的行、列和父索引，返回对应项的QModelIndex 对象
        parentNode = self.getNode(parent)
        childItem = parentNode.child(row)

        if childItem:
            return self.createIndex(row, column, childItem)
        else:
            return QModelIndex()
    
    def setData(self, index, value, role=Qt.ItemDataRole.EditRole):
        # 根据需要实现的方法，设置给定索引处项的特定角色的数据
        if index.isValid():
            if role == Qt.ItemDataRole.EditRole:
                node = index.internalPointer()
                node.setData(index.column(), value)
                return True

        return False

    def headerData(self, section, orientation, role):
        # 根据需要实现的方法，返回指定行或列的标题数据
        if (orientation == Qt.Horizontal and
                role == Qt.DisplayRole):
            return self._rootNode.data(section)

        return None

    def flags(self, index):
        # 根据需要实现的方法，返回给定索引处项的标志，用于指定项的状态和行为
        return Qt.ItemIsEnabled | Qt.ItemIsSelectable | Qt.ItemIsEditable

    def getNode(self, index):
        # 根据需要实现的方法，返回给定索引处项的节点
        if index.isValid():
            node = index.internalPointer()
            if node:
                return node

        return self._rootNode
    def insertRows(self, row, count, parent=QModelIndex()):
        # 根据需要实现的方法，在指定的父索引下插入行
        parentNode = self.getNode(parent)
        self.beginInsertRows(parent, row, row + count - 1)
        for r in range(count):
            childCount = parentNode.childCount()
            childNode = CustomNode(['', '', ''], parentNode)
            self.insertRows(childCount, 1, self.index(row, 0, parent))
        self.endInsertRows()
        return True
    
    def removeRows(self, row, count, parent=QModelIndex()):
        # 根据需要实现的方法，删除指定父索引下的行
        parentNode = self.getNode(parent)
        self.beginRemoveRows(parent, row, row + count - 1)
        for r in range(count):
            childCount = parentNode.childCount()
            self.removeRows(childCount - 1, 1, self.index(row, 0, parent))
        self.endRemoveRows()
        return True
    
    def insertColumns(self, column, count, parent=QModelIndex()):
        # 根据需要实现的方法，在指定的父索引下插入列
        self.beginInsertColumns(parent, column, column + count - 1)
        self.endInsertColumns()
        return True
    
    def removeColumns(self, column, count, parent=QModelIndex()):
        # 根据需要实现的方法，删除指定父索引下的列
        self.beginRemoveColumns(parent, column, column + count - 1)
        self.endRemoveColumns()
        return True

```

# QTabwidget

## indexof
根据tab的标签页对象获取tab的索引
```python
tab = QWidget()
tabwidget.addTab(tab, 'tab')
index = tabwidget.indexOf(tab)
```