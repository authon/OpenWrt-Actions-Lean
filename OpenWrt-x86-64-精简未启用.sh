  
#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# 定制默认IP
sed -i 's/192.168.1.1/10.10.10.1/g' package/base-files/files/bin/config_generate

# 替换默认Argon主题
# rm -rf package/lean/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

# 添加第三方软件包
git clone https://github.com/KFERMercer/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
git clone https://github.com/vernesong/OpenClash package/luci-app-OpenClash

#创建自定义配置文件 - OpenWrt-x86-64

rm -f ./.config*
touch ./.config

#
# ========================固件定制部分========================
# 

# 
# 如果不对本区块做出任何编辑, 则生成默认配置固件. 
# 

# 以下为定制化固件选项和说明:
#

#
# 有些插件/选项是默认开启的, 如果想要关闭, 请参照以下示例进行编写:
# 
#          =========================================
#         |  # 取消编译VMware镜像:                   |
#         |  cat >> .config <<EOF                   |
#         |  # CONFIG_VMDK_IMAGES is not set        |
#         |  EOF                                    |
#          =========================================
#

# 
# 以下是一些提前准备好的一些插件选项.
# 直接取消注释相应代码块即可应用. 不要取消注释代码块上的汉字说明.
# 如果不需要代码块里的某一项配置, 只需要删除相应行.
#
# 如果需要其他插件, 请按照示例自行添加.
# 注意, 只需添加依赖链顶端的包. 如果你需要插件 A, 同时 A 依赖 B, 即只需要添加 A.
# 
# 无论你想要对固件进行怎样的定制, 都需要且只需要修改 EOF 回环内的内容.
# 

# 编译x64固件:
cat >> .config <<EOF
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
EOF

设置固件大小:
cat >> .config <<EOF
CONFIG_TARGET_KERNEL_PARTSIZE=300
CONFIG_TARGET_ROOTFS_PARTSIZE=500
EOF

# 固件压缩:
cat >> .config <<EOF
CONFIG_TARGET_IMAGES_GZIP=y
EOF

# 编译UEFI固件:
cat >> .config <<EOF
CONFIG_EFI_IMAGES=y
EOF

# IPv6支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
# CONFIG_PACKAGE_ipv6helper=y
# EOF

# 多文件系统支持:
cat >> .config <<EOF
CONFIG_PACKAGE_kmod-fs-nfs=y
CONFIG_PACKAGE_kmod-fs-nfs-common=y
CONFIG_PACKAGE_kmod-fs-nfs-v3=y
CONFIG_PACKAGE_kmod-fs-nfs-v4=y
CONFIG_PACKAGE_kmod-fs-ntfs=y
CONFIG_PACKAGE_kmod-fs-squashfs=y
EOF

# USB3.0支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-usb-ohci=y
# CONFIG_PACKAGE_kmod-usb-ohci-pci=y
# CONFIG_PACKAGE_kmod-usb2=y
# CONFIG_PACKAGE_kmod-usb2-pci=y
# CONFIG_PACKAGE_kmod-usb3=y
# EOF

# 第三方插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-serverchan=y #微信推送
CONFIG_PACKAGE_luci-app-adguardhome=y #ADguardHome去广告服务
CONFIG_PACKAGE_luci-app-openclash=y
EOF

# lienol插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-fileassistant=y
CONFIG_PACKAGE_luci-app-filebrowser=y
CONFIG_PACKAGE_luci-app-ramfree=y #内存释放
# CONFIG_PACKAGE_luci-app-control-mia=y #时间控制
# CONFIG_PACKAGE_luci-app-control-timewol=y #定时唤醒
# CONFIG_PACKAGE_luci-app-control-webrestriction=y #访问限制
# CONFIG_PACKAGE_luci-app-control-weburl=y #网址过滤
CONFIG_PACKAGE_luci-app-passwall=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ipt2socks=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_socks=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_socks=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_Plus=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_Go=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Brook=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_kcptun=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_haproxy=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ChinaDNS_NG=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_dns2socks=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_pdnsd=y
# CONFIG_PACKAGE_kcptun-client=y
# CONFIG_PACKAGE_chinadns-ng=y
# CONFIG_PACKAGE_v2ray=y
# CONFIG_PACKAGE_trojan-Plus=y
# CONFIG_PACKAGE_trojan-Go=y
# CONFIG_PACKAGE_brook=y
# CONFIG_PACKAGE_ipt2socks=y


EOF

# 常用LuCI插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-transmission=y
CONFIG_PACKAGE_luci-app-adbyby-plus=y
CONFIG_PACKAGE_luci-app-aria2=y
CONFIG_PACKAGE_luci-app-baidupcs-web=y
# CONFIG_PACKAGE_luci-app-minidlna=y
# CONFIG_PACKAGE_luci-app-openvpn=y
# CONFIG_PACKAGE_luci-app-openvpn-server=y
CONFIG_PACKAGE_luci-app-ssr-plus=y
CONFIG_PACKAGE_luci-app-ttyd=y
CONFIG_PACKAGE_luci-app-verysync=y
CONFIG_PACKAGE_luci-app-wireguard=y
CONFIG_PACKAGE_luci-app-wrtbwmon=y
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_luci-app-firewall=y
CONFIG_PACKAGE_luci-app-upnp=y #通用即插即用UPnP(端口自动转发)
CONFIG_PACKAGE_luci-app-flowoffload=y #Turbo ACC 网络加速
CONFIG_PACKAGE_luci-app-nlbwmon=y #宽带流量监控
CONFIG_PACKAGE_luci-app-wol=y #网络唤醒
CONFIG_PACKAGE_luci-app-acme=y
CONFIG_PACKAGE_luci-app-arpbind=y #IP/MAC绑定
CONFIG_PACKAGE_luci-app-autoreboot=y #定时重启
CONFIG_PACKAGE_luci-app-filetransfer=y #系统-文件传输
CONFIG_PACKAGE_luci-app-watchcat=y
CONFIG_PACKAGE_luci-app-netdata=y
CONFIG_PACKAGE_luci-app-smartdns=y #smartdnsDNS服务
CONFIG_PACKAGE_luci-app-autoreboot=y #定时重启
# CONFIG_DEFAULT_luci-app-vlmcsd=y #KMS激活服务器
CONFIG_DEFAULT_luci-app-webadmin=y
CONFIG_DEFAULT_luci-app-ssr-plus=y
CONFIG_DEFAULT_luci-app-uhttpd=y
CONFIG_DEFAULT_luci-app-ntpc=y
EOF

# LuCI主题:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-theme-argon=y
CONFIG_PACKAGE_luci-theme-netgear=y
CONFIG_PACKAGE_luci-theme-argon-dark-mod=y
CONFIG_PACKAGE_luci-theme-argon-light-mod=y
CONFIG_PACKAGE_luci-theme-bootstrap-mod=y
CONFIG_PACKAGE_luci-theme-netgear-mc=y
EOF

# 常用软件包:
cat >> .config <<EOF
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_screen=y
CONFIG_PACKAGE_tree=y
CONFIG_PACKAGE_vim-fuller=y
CONFIG_PACKAGE_wget=y
EOF

# 取消编译VMware镜像以及镜像填充 (不要删除被缩进的注释符号):
cat >> .config <<EOF
# CONFIG_TARGET_IMAGES_PAD is not set
# CONFIG_VMDK_IMAGES is not set
EOF

# 
# ========================固件定制部分结束========================
# 


sed -i 's/^[ \t]*//g' ./.config

# 配置文件创建完成
