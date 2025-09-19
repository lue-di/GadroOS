#!/bin/bash

echo "==> Change apt Source"
# rm -f /etc/apt/sources.list.d/*.list
# cat > /etc/apt/sources.list <<EOF
# deb $DEBIAN_MIRROR/debian $DEBIAN_VERSION main contrib non-free non-free-firmware
# deb $DEBIAN_MIRROR/debian $DEBIAN_VERSION-updates main contrib non-free non-free-firmware
# deb $DEBIAN_MIRROR/debian-security $DEBIAN_VERSION-security main contrib non-free non-free-firmware
# EOF
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources      
echo '==> Update Apt Package...'
apt-get update && apt-get upgrade -y
apt-get install -y --no-install-recommends live-build debootstrap  systemd-sysv iputils-ping curl curl gpg ca-certificates apt-transport-https lsb-release wget
# mkdir -p /etc/apt/{sources.list.d,keyrings}
# chmod 0755 /etc/apt/{sources.list.d,keyrings}
# keyring_url='https://liquorix.net/liquorix-keyring.gpg'
# keyring_path='/etc/apt/keyrings/liquorix-keyring.gpg'
# curl -fsSL "$keyring_url" | gpg --batch --yes --output "$keyring_path" --dearmor
# chmod 0644 "$keyring_path"
# repo_code=$(apt-cache policy | grep o=Debian | grep -Po 'n=\w+' | cut -f2 -d= | sort | uniq -c | sort | tail -n1 | awk '{print $2}')
# repo_file="/etc/apt/sources.list.d/liquorix.list"
# repo_line="[arch=amd64 signed-by=$keyring_path] https://liquorix.net/debian $repo_code main"
# echo "deb $repo_line"      > "$repo_file"
# echo "deb-src $repo_line" >> "$repo_file"
# echo "Liquorix repository added successfully to $repo_file"
# wget -qO - https://dl.xanmod.org/archive.key | gpg --dearmor -vo /etc/apt/keyrings/xanmod-archive-keyring.gpg
# echo "deb [signed-by=/etc/apt/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/xanmod-release.list
# echo '==> Added XanMod Kernel gpg'
# apt-get update -y
cd /workspace || exit
echo '==> Enter /workspace '

# 设置退出 trap
#trap 'echo "==> Leave Gadro Docker Build Environment"; cd /workspace; lb clean' EXIT

# 启动交互 shell
exec /bin/bash 