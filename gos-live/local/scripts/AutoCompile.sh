#!/bin/bash
# Auto Build script
set -euo pipefail

echo '==> Update Apt Package...'
apt-get update && apt-get upgrade -y
apt-get install -y --no-install-recommends live-build debootstrap  systemd-sysv iputils-ping curl  curl gpg ca-certificates apt-transport-https wget
update-ca-certificates
apt-get update -y
echo "=== 根证书列表 (/etc/ssl/certs) ==="
for cert in /etc/ssl/certs/*.crt; do
    echo "文件: $cert"
done
cd /workspace || exit
echo '==> Enter /workspace '

sed -i 's#https://mirrors.tuna.tsinghua.edu.cn/debian#http://deb.debian.org/debian#g' "/workspace/auto/config"

lb build

exit $?

