#!/bin/bash

# drivers for mt7615
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/mt package/new/mt
svn co https://github.com/Lienol/openwrt/tree/main/package/lean/mt package/new/mt
echo "/etc/wireless/" >> package/base-files/files/lib/upgrade/keep.d/mtwifi

# access control
svn co https://github.com/coolsnowwolf/lede/tree/main/package/lean/luci-app-accesscontrol package/new/luci-app-accesscontrol
# FullCone
svn co https://github.com/Lienol/openwrt/tree/main/package/network/fullconenat package/new/openwrt-fullconenat
wget -P target/linux/generic/hack-4.14/ https://raw.githubusercontent.com/Lienol/openwrt/19.07/target/linux/generic/hack-4.14/952-net-conntrack-events-support-multiple-registrant.patch
pushd feeds/luci
cat ../../../patches/fullconenat-luci.patch | git apply
popd
mkdir -p package/network/config/firewall/patches
wget -P package/network/config/firewall/patches/ https://raw.githubusercontent.com/Lienol/openwrt/19.07/package/network/config/firewall/patches/fullconenat.patch
# IPv6 helper
svn co https://github.com/coolsnowwolf/lede/tree/main/package/lean/ipv6-helper package/new/ipv6-helper
# Passwall
svn co https://github.com/xiaorouji/openwrt-passwall/tree/main/luci-app-passwall package/new/luci-app-passwall
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/shadowsocks-libev
svn co https://github.com/xiaorouji/openwrt-passwall/tree/main/ipt2socks package/new/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/tree/main/microsocks package/new/microsocks
svn co https://github.com/xiaorouji/openwrt-passwall/tree/main/pdnsd-alt package/new/pdnsd
svn co https://github.com/xiaorouji/openwrt-passwall/tree/main/tcping package/new/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/tree/main/shadowsocksr-libev package/new/shadowsocksr-libev
svn co https://github.com/coolsnowwolf/packages/tree/main/net/shadowsocks-libev package/new/shadowsocks-libev
# Scheduled Reboot
svn co https://github.com/coolsnowwolf/lede/tree/main/package/lean/luci-app-autoreboot package/new/luci-app-autoreboot
# SeverChan
git clone -b master --depth 1 --single-branch https://github.com/tty228/luci-app-serverchan package/new/luci-app-serverchan
# Traffic Usage Monitor
git clone -b master --depth 1 --single-branch https://github.com/brvphoenix/wrtbwmon package/new/wrtbwmon
git clone -b master --depth 1 --single-branch https://github.com/brvphoenix/luci-app-wrtbwmon package/new/luci-app-wrtbwmon
# upx & ucl
svn co https://github.com/coolsnowwolf/lede/tree/main/tools/ucl tools/ucl
svn co https://github.com/coolsnowwolf/lede/tree/main/tools/upx tools/upx
sed -i '/builddir dependencies/i\tools-y += ucl upx' tools/Makefile
sed -i '/builddir dependencies/a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile
# vlmcsd
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/lean/luci-app-vlmcsd package/new/luci-app-vlmcsd
svn co https://github.com/coolsnowwolf/lede/tree/main/package/lean/vlmcsd package/lean/vlmcsd
# Zerotier
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/lean/luci-app-zerotier package/new/luci-app-zerotier
# zram-swap
rm -rf package/system/zram-swap
svn co https://github.com/openwrt/openwrt/tree/main/package/system/zram-swap package/system/zram-swap

# default settings and translate
cp -rf ../default-settings package/new/lean-translate

exit 0
