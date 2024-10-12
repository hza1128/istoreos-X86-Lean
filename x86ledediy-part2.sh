#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 设置默认ip
sed -i 's/192.168.1.1/192.168.10.12/g' package/base-files/files/bin/config_generate

# 设置默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argone/g' feeds/luci/collections/luci/Makefile

# Modify hostname
# sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate


# x86 型号只显示 CPU 型号
# sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修改本地时间格式
# sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by hza1128/g" package/lean/default-settings/files/zzz-default-settings

# 添加插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
# 删除重复插件
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}
rm -rf feeds/smpackage/adguardhome
rm -rf feeds/smpackage/luci-app-adguardhome
# uu加速器下载失败
#sed -i "s/openwrt-\$(UU_ARCH)\/\$(PKG_VERSION)\/uu.tar.gz?/openwrt-\$(UU_ARCH)\/\$(PKG_VERSION)\//g" feeds/packages/net/uugamebooster/Makefile
#sed -i "s/\$(PKG_NAME)-\$(UU_ARCH)-\$(PKG_VERSION).tar.gz/uu.tar.gz/g" feeds/packages/net/uugamebooster/Makefile
