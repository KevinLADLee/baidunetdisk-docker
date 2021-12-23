FROM jlesage/baseimage-gui:debian-9

ENV VERSION=4.3.0
ENV URI=http://issuecdn.baidupcs.com/issue/netdisk/LinuxGuanjia/$VERSION/baidunetdisk_${VERSION}_amd64.deb

ENV DISPLAY=":1"
ENV ENABLE_CJK_FONT=1
ENV TZ=Asia/Shanghai

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget                  \
                          desktop-file-utils    \
                          libasound2-dev        \
                          locales               \
                          fonts-wqy-zenhei      \   
                          libgtk-3-0            \
                          libnotify4            \
                          libnss3               \
                          libxss1               \
                          libxtst6              \
                          xdg-utils             \
                          libatspi2.0-0         \
                          libuuid1              \  
                          libappindicator3-1    \
                          libsecret-1-0         \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q ${URI} -O /defaults/baidunetdisk.deb     \
    && apt-get install -y /defaults/baidunetdisk.deb \
    && rm /defaults/baidunetdisk.deb 

RUN \
    APP_ICON_URL='https://raw.githubusercontent.com/KevinLADLee/baidunetdisk-docker/master/logo.png' && \
    install_app_icon.sh "$APP_ICON_URL"

COPY rootfs/ /

ENV APP_NAME="BaiduNetdisk" \
    S6_KILL_GRACETIME=8000

WORKDIR /config

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/downloads"]
