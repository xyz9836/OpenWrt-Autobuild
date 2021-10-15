#!/bin/bash

# drivers for mt7615
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/mt package/new/mt
#svn co https://github.com/Lienol/openwrt/truk/package/lean/mt package/new/mt
svn co https://github.com/Lienol/openwrt/trunk/package/lean/MTK7615-DBDC-LINUX5.4 package/new/mt
echo "/etc/wireless/" >> package/base-files/files/lib/upgrade/keep.d/mtwifi

# access control
svn co https://github.com/coolsnowwolf/lede/truk/package/lean/luci-app-accesscontrol package/new/luci-app-accesscontrol
# FullCone
svn co https://github.com/Lienol/openwrt/truk/package/network/fullconenat package/new/openwrt-fullconenat
wget -P target/linux/generic/hack-4.14/ https://raw.githubusercontent.com/Lienol/openwrt/19.07/target/linux/generic/hack-4.14/952-net-conntrack-events-support-multiple-registrant.patch
pushd feeds/luci
cat ../../../patches/fullconenat-luci.patch | git apply
popd
mkdir -p package/network/config/firewall/patches
wget -P package/network/config/firewall/patches/ https://raw.githubusercontent.com/Lienol/openwrt/19.07/package/network/config/firewall/patches/fullconenat.patch
# IPv6 helper
svn co https://github.com/coolsnowwolf/lede/truk/package/lean/ipv6-helper package/new/ipv6-helper
# Passwall
svn co https://github.com/xiaorouji/openwrt-passwall/truk/luci-app-passwall package/new/luci-app-passwall
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/shadowsocks-libev
svn co https://github.com/xiaorouji/openwrt-passwall/truk/ipt2socks package/new/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/truk/microsocks package/new/microsocks
svn co https://github.com/xiaorouji/openwrt-passwall/truk/pdnsd-alt package/new/pdnsd
svn co https://github.com/xiaorouji/openwrt-passwall/truk/tcping package/new/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/truk/shadowsocksr-libev package/new/shadowsocksr-libev
svn co https://github.com/coolsnowwolf/packages/truk/net/shadowsocks-libev package/new/shadowsocks-libev
# Scheduled Reboot
svn co https://github.com/coolsnowwolf/lede/truk/package/lean/luci-app-autoreboot package/new/luci-app-autoreboot
# SeverChan
git clone -b master --depth 1 --single-branch https://github.com/tty228/luci-app-serverchan package/new/luci-app-serverchan
# Traffic Usage Monitor
git clone -b master --depth 1 --single-branch https://github.com/brvphoenix/wrtbwmon package/new/wrtbwmon
git clone -b master --depth 1 --single-branch https://github.com/brvphoenix/luci-app-wrtbwmon package/new/luci-app-wrtbwmon
# upx & ucl
svn co https://github.com/coolsnowwolf/lede/truk/tools/ucl tools/ucl
svn co https://github.com/coolsnowwolf/lede/truk/tools/upx tools/upx
sed -i '/builddir dependencies/i\tools-y += ucl upx' tools/Makefile
sed -i '/builddir dependencies/a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile
# vlmcsd
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/lean/luci-app-vlmcsd package/new/luci-app-vlmcsd
svn co https://github.com/coolsnowwolf/lede/truk/package/lean/vlmcsd package/lean/vlmcsd
# Zerotier
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/lean/luci-app-zerotier package/new/luci-app-zerotier
# zram-swap
rm -rf package/system/zram-swap
svn co https://github.com/openwrt/openwrt/truk/package/system/zram-swap package/system/zram-swap


#https://github.com/kenzok8/small
#不定期同步大神库更新，适合一键下载到package目录下，用于openwrt编译
#cd ./package/new
#git clone https://github.com/kenzok8/small.git
git clone -b master --depth 1 --single-branch https://github.com/kenzok8/small package/new
#cd ..
#cd ..


# default settings and translate
cp -rf ../default-settings package/new/lean-translate

exit 0
