FROM jlesage/baseimage-gui:debian-9

ENV VERSION=3.0.1.2
ENV URI=http://wppkg.baidupcs.com/issue/netdisk/LinuxGuanjia/3.0.1/baidunetdisk_linux_3.0.1.2.deb
ENV DISPLAY=":1"
ENV ENABLE_CJK_FONT=1
ENV TZ=Asia/Shanghai

# RUN apt-get update && apt-get install -y --no-install-recommends apt-transport-https ca-certificates \
#     && sed -i "s@http://ftp.debian.org@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list \
#     && sed -i "s@http://security.debian.org@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list \
#     && sed -i "s@http://deb.debian.org@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list \
#     && sed -i "s@http://deb.nodesource.com/node_8.x@https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_8.x/@g" /etc/apt/sources.list.d/nodesource.list

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget                  \
                          desktop-file-utils    \
                          libnss3               \
                          libgtk-3-dev          \
                          libxss-dev            \
                          libasound2-dev        \
                          locales               \
                          fonts-wqy-zenhei      \   
    && rm -rf /var/lib/apt/lists/*

RUN wget ${URI} -O /defaults/baidunetdisk.deb     \
    && apt-get install -y /defaults/baidunetdisk.deb \
    && rm /defaults/baidunetdisk.deb 

RUN \
    APP_ICON_URL='https://raw.githubusercontent.com/KevinLADLee/icon/master/baidunetdisk.png' && \
    install_app_icon.sh "$APP_ICON_URL"

COPY rootfs/ /
COPY VERSION /

ENV APP_NAME="BaiduNetdisk" \
    S6_KILL_GRACETIME=8000

WORKDIR /config

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/downloads"]