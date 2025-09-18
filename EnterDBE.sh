#!/bin/bash

#Enter Gadro Docker Build Environment

# 1. 设置工作目录（修改为你的本地路径）
HOST_WORKDIR="./gos-live"
CONTAINER_NAME="gadro-live"
DEBIAN_VERSION="bookworm"
# Give Permission
sudo chmod 777 * -R 

# 2. 拉取最新 Debian 镜像
echo "==> 拉取 Debian 镜像: $DEBIAN_VERSION"
docker pull docker.m.daocloud.io/debian:$DEBIAN_VERSION

# 3. 检查是否已有同名容器，若有则删除
if docker ps -a --format '{{.Names}}' | grep -Eq "^$CONTAINER_NAME\$"; then
    echo "==> 已存在容器 $CONTAINER_NAME，先删除..."
    docker rm -f $CONTAINER_NAME
fi

chmod +x $HOST_WORKDIR/local/scripts/docker-init.sh
# 4. 创建并启动容器，挂载工作目录
echo "==> 创建并启动容器 $CONTAINER_NAME，挂载工作目录 $HOST_WORKDIR"
docker run -it --privileged --name $CONTAINER_NAME \
    -v "$HOST_WORKDIR":/workspace \
    -e all_proxy=socks5://10.10.10.12:7890 \
    docker.m.daocloud.io/debian:$DEBIAN_VERSION /bin/bash -c "/workspace/local/scripts/docker-init.sh"

