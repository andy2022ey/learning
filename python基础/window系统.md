# 获取windows系统的参数信息
```python
import wmi
# 获取CPU序列号
c = wmi.WMI()
processors = c.Win32_Processor()
for processor in processors:
    serial_number = processor.ProcessorId
    print(serial_number)
# 等同于在命令行中输入wmic CPU get ProcessorID

# 获取硬盘序列号
c = wmi.WMI()
for physical_disk in c.Win32_DiskDrive():
    for partition in physical_disk.associators("Win32_DiskDriveToDiskPartition"):
        for logical_disk in partition.associators("Win32_LogicalDiskToPartition"):
            print(physical_disk.SerialNumber)
# 等同于在命令行中输入wmic diskdrive get serialnumber

# 获取（UUID）
c = wmi.WMI()
computer = c.Win32_ComputerSystem()[0]
print(computer.UUID)


```