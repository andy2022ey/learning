# 脚本文件
NSIS脚本文件需要用带有BOM的UTF-8编码保存，文件名以.nsi结尾

# 常用变量
$INSTDIR：用户自定义安装目录
$PROGRAMFILES：系统自带，通常是C:\Program Files
$PROGRAMFILES32：系统自带，通常是C:\Program Files (x86)
$DESKTOP：桌面
$SMPROGRAMS：开始菜单
$TEMP：临时文件夹
$STARTMENU：开始菜单
$SMPROGRAMS：开始菜单
$SMSTARTUP：开始菜单的启动项
$SENDTO："发送到"菜单
$RECENT：最近打开的文件
$HISTORY：Internet Explorer 的历史记录目录

# 创建安装和卸载程序
```nsis
Section "安装程序" SEC01
    ; 创建安装目录
    SetOutPath "$INSTDIR"
    ; 安装文件
    File "myapp.exe"
    File "readme.txt"
    ; 创建快捷方式
    CreateDirectory "$SMPROGRAMS\My Application"
    CreateShortCut "$SMPROGRAMS\My Application\My Application.lnk" "$INSTDIR\myapp.exe" "" "$INSTDIR\myapp.exe" 0
    ; 创建卸载程序
    WriteUninstaller "$INSTDIR\Uninstall.exe"
    ; 在注册表中创建卸载程序条目
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\My Application" "DisplayName" "My Application"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\My Application" "UninstallString" "$INSTDIR\Uninstall.exe"
SectionEnd
```
WriteUninstaller 指令用于在安装目录中创建一个名为“Uninstall.exe”的卸载程序
WriteRegStr 指令用于在 Windows 注册表中创建一个卸载程序的条目，该条目包括安装程序的名称和卸载程序的路径。
HKLM 参数表示该注册表键将被写入到计算机的“HKEY_LOCAL_MACHINE”部分，而不是当前用户的注册表

