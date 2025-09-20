#!/bin/bash
# Auto Build script
set -euo pipefail

echo '==> Update Apt Package...'
apt-get update && apt-get upgrade -y
apt-get install -y --no-install-recommends live-build debootstrap  systemd-sysv iputils-ping curl  curl gpg apt-transport-https wget
apt install --only-upgrade -y ca-certificates
apt-get update -y
echo "=== Sources ==="

cat /etc/apt/sources.list.d/debian.sources

cd /workspace || exit
echo '==> Enter /workspace '

sed -i 's#https://mirrors.tuna.tsinghua.edu.cn/debian#http://deb.debian.org/debian#g' "/workspace/auto/config"

lb build

exit $?

