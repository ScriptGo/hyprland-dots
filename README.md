<div align="center"> <h1> ArchLinux HyprLand 配置参考 </h1>  </div>



- 首先要有一个安装好且干净的 ArchLinux 环境
- NetworkManager 服务已配置为开机自启
- 镜像源已经配置好
- 已经创建好一个普通用户账户



**现在用普通用户登录系统，从零开始配置 HyprLand !**



**一. 连接无线网络**

显示附近的 Wi-Fi 网络  
`nmcli dev wifi list`  

连接无线网络  
`nmcli dev wifi connect SSID password "网络密码"` 

**测试网络**

通过 ping 命令测试网络连通性：
`ping -c 3 www.archlinux.org`

稍等片刻，若能看到数据返回，说明已经联网。



**二. 更新系统**

`sudo pacman -Syyu`



**三. 安装 HyprLand**

`sudo pamcan -S hyprland`



**四. 安装 qt-wayland 支持**

`sudo pacman -S qt5-wayland qt6-wayland glfw-wayland `



**五. **
