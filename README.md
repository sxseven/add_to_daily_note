# 目标
按指定组合键（默认ctrl+shift+D）唤起一个输入框，输入任意内容之后自动添加到指定位置的指定文件
ps：
如果文件不存在会自动创建文件
我这里使用的是日期（yyyy-M-d）命名的文件
# 使用说明
## 文件
```
add_to_daily_note.ahk，其中ahk文件采用的语法是v2版本，与v1不兼容
add_to_daily_note.ps1，PowerShell 脚本
```
## 前置软件配置
需要在[https://www.autohotkey.com/](ahk官网)下载v2版本并安装，安装到任意位置均可
## 开机自启流程
1. 按 `Win + R` 打开运行对话框
2. 输入以下命令之一：
    - 当前用户启动：`shell:startup`
    - 所有用户启动：`shell:common startup`
3.  将add_to_daily_note.ahk的快捷方式拖动到出现的文件夹里
## 参数调整
### 必须调整的参数
ahk文件中
```
psScript：ps1文件存放路径，使用绝对地址
```
ps1文件中
```
VaultPath：md文件存放地址，使用绝对地址
```
### 可以调整的参数
ahk文件中
```
^+d：唤起输入框的键位，目前是ctrl+shift+D，建议提前测试组合键是否冲突，可以咨询模型你想要的组合键的写法

可配置参数下方内容：可以调节窗口的大小、位置等，具体调节什么可以看命名or注释

SetFont：调节字体字号等
```
ps1文件中
```
FileName：文件命名方式，默认采用yyyy-M-d

Line：对输入内容的处理，目前是时间戳（HH:mm:ss）+内容
```
