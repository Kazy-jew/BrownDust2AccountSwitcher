# 棕色尘埃2多账号切换
1.在合适位置新建一个文件夹，把`launcher1.bat`里第9行的`root`地址换掉，比如如果在D盘建立了一个`browndust2`的文件夹，那么第9行就是
```set root=D:\browndust2\```；\
2.有几个账号就拷贝几份`launcher1.bat`，然后把第6行的数字改掉，比如有3个账号，就对应三个脚本，比如说是`launcher1.bat`, `launcher2.bat`, `launcher3.bat`,
里面的第6行分别改成`set const=1`, `set const=2`, `set const=3`，分别对应三个账号；\
3.想登哪个账号就双击对应的脚本即可，初次启动如果是别的账号/未登录的状态游戏里切一下账号，下次打开脚本就是对应的账号了\
PS: 如果游戏启动器没有安装在默认的位置，那么46行的启动器路径```C:\ProgramData\Neowiz\Browndust2Starter\Browndust2Starter.exe```也需要替换下
