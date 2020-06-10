# Docker版百度网盘官方Linux版客户端

适用于各种支持Docker的NAS，以及Unraid，使用百度网盘官方版Linux客户端。

如何使用：

```bash
docker run -d \ 
--name baidunetdisk \ 
-v /PATH_TO_CONFIG:/config \ 
-v /PATH_TO_DOWNLOADS:/downloads \ 
-e GROUP_ID=1000 \ 
-e USER_ID=1000 \ 
-p 5800:5800 \ 
-p 5900:5900  \ 
-e ENABLE_CJK_FONT=1 \ 
kevinlad/baidunetdisk-docker:latest
```

等待初始化完成后，可以在浏览器端打开 `http://127.0.0.1:5800`。也可以使用任何VNC客户端连接`5900`端口。

查看自己的`USER_ID`和`GROUP_ID` :

```bash
id USERNAME
```

此Docker基于`jlesage/baseimage-gui:debian-9`，其他详细参数可参考其[文档](https://github.com/jlesage/docker-baseimage-gui)。

