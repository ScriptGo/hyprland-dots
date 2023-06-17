<div align="center"> <h1> ArchLinux HyprLand 配置参考 </h1>  </div>



- 首先要有一个安装好且干净的 ArchLinux 环境
- 确保网络环境已经配置好(NetworkManager服务已配置为开机自启)
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




## 镜像

**首先请连接无线网(点击右下角的网络图标)**

1.配置

`sudo pacman-mirrors -i -c China -m rank`

2.同步源

`sudo pacman -Syy`

3.更新系统

`sudo pacman -Syyu`

## AUR

1.编辑pacman.conf文件

`sudo vim /etc/pacman.conf`

在文件的末尾加上两行内容：

```shell
[archlinuxcn]
Server = https://repo.archlinuxcn.org/$arch
```

2.小彩蛋

在pacman.conf文件内找到 #Misc options，将其内容修改为：

```shell
Color
VerbosePkgLists
ILoveCandy
```

3.同步源

`sudo pacman -Syy`

4.导入GPG key

`sudo pacman -S archlinuxcn-keyring`

5.更新系统

`sudo pacman -Syyu`


## 必装

```shell
sudo pacman -S --needed base-devel  # 必须安装,不然 makepkg会提示错误
sudo pacman -S jre17-openjdk        # 安装完执行 source /etc/profile.d/jre.sh
sudo pacman -S yay                  # 从 Aur 中安装软件
```

执行以下命令修改 aururl :

`yay --aururl "https://aur.archlinux.org" --save`

修改的配置文件位于 ~/.config/yay/config.json

## 字体

中文

```bash
sudo pacman -S noto-fonts-cjk noto-fonts-emoji ttf-sarasa-gothic
```

英文

```bash
sudo pacman -S ttf-fira-code ttf-jetbrains-mono
```

Nerd

```bash
sudo pacman -S ttf-firacode-nerd ttf-jetbrains-mono-nerd
```

图标

```bash
sudo pacman -S awesome-terminal-fonts ttf-font-awesome otf-font-awesome
yay -S ttf-material-design-icons-webfont
```

刷新字库

`fc-cache -f -v`

## 常用

```bash

```

| 应用类型                       | 安装方式                                   | 其他                                                       |
| :----------------------------- | :----------------------------------------- | :--------------------------------------------------------- |
| 终端                           | sudo pacman -S alacritty                   |                                                            |
| MD编辑器                       | sudo pacman -S typora                      |                                                            |
| 磁盘管理                       | sudo pacman -S gparted                     |                                                            |
| 启动盘制作                     | sudo pacman -S ventoy                      |                                                            |
| 防火墙                         | sudo pacman -S gufw                        | 启动防火墙 sudo ufw enable                                 |
| 笔记                           | sudo pacman -S joplin-desktop              |                                                            |
| 字体管理器                     | sudo pacman -S font-manager                |                                                            |
| 办公软件                       | sudo pacman -S libreoffice                 |                                                            |
| PDF阅读器                      | sudo pacman -S zathura zathura-pdf-poppler |                                                            |
| 系统备份                       | sudo pacman -S timeshift                   |                                                            |
| 图片处理                       | sudo pacman -S gimp inkscape               |                                                            |
| 科学上网                       | sudo pacman -S v2ray-desktop               |                                                            |
| 浏览器                         | yay -S google-chrome                       |                                                            |
|                                |                                            |                                                            |
| 网络工具包                     | sudo pacman -S net-tools                   |                                                            |
| 替代curl                       | sudo pacman -S httpie                      |                                                            |
| 显示系统信息                   | sudo pacman -S neofetch                    |                                                            |
| 娱乐工具                       | sudo pacman -S fortune-mod cowsay          |                                                            |
| 娱乐工具                       | sudo pacman -S sl cmatrix                  |                                                            |
| 替换 find 的查找工具           | sudo pacman -S fd                          |                                                            |
| 替换 grep 更高速的正则匹配工具 | sudo pacman -S ripgrep                     |                                                            |
| 替换 cat 的文件内容查看工具    | sudo pacman -S bat                         |                                                            |
| 命令行下查看 json 文件         | sudo pacman -S jq                          |                                                            |
|                                | sudo pacman -S tree                        |                                                            |
|                                | sudo pacman -S graphviz                    |                                                            |
| 简化版 man 手册                | sudo pacman -S tldr                        | `注意: 第一次使用tldr之前，需要更新一下缓存 tldr --update` |
|                                | sudo pacman -S lolcat                      |                                                            |
| 模糊查找                       | sudo pacman -S fzf                         |                                                            |
|                                | sudo pacman -S zenity                      |                                                            |





## tmux

1.安装
`sudo pacman -S tmux`

2. 配置

```bash
git clone https://github.com/gpakosz/.tmux.git
复制其中的 .tmux.conf 和 .tmux.conf.local 文件到主目录下
```

## 蓝牙配置

`sudo pacman -S bluez bluez-utils blueman` # 安装软件

启动服务

```bash
sudo systemctl start bluetooth
sudo systemctl enable bluetooth
```

然后打开 `blueman`设置即可

**蓝牙耳机已连接但是没有声音**

`sudo pacman -S pavucontrol` # 安装这些软件

启动pulseaudio服务

```bash
pulseaudio -k                      # 确保没有pulseaudio启动
pulseaudio --start                 # 启动pulseaudio服务
systemctl enable pulseaudio --user
```

重新启动蓝牙服务

`sudo systemctl restart bluetooth`

到蓝牙的设备管理器中将蓝牙耳机移除，重新连接

## 娱乐

```bash
sudo pacman -S ffmpeg ffmpegthumbnailer              # 解码工具
sudo pacman -S mpv                                   # 视频播放器
sudo pacman -S mpd mpc ncmpcpp                       # 音乐播放器
```

复制配置文件到 ~/.config 目录下

之后把 mpd 和 ncmpcpp 配置里面的音乐目录改成你的音乐路径即可

```
systemctl start mpd.service --user  # 启动mpd服务
systemctl enable mpd.service --user # 可以设置成自动启动
```

之后启动ncmpcpp

出现问题之后首先检查mpd的日志

`systemctl status mpd --user`

根据不同的提示来解决问题

## 触摸板

使用 `xinput list` # 查看设备
`xinput --disable "ETPS/2 Elantech Touchpad"` # 禁用触摸板

## 启用 TRIM

TRIM 会帮助清理 SSD 中的块，从而延长 SSD 的使用寿命。

`sudo systemctl enable fstrim.timer`


## 美化

美化资源

```bash
https://www.gnome-look.org/p/1275087
https://www.gnome-look.org/p/1447933
https://www.gnome-look.org/p/1449286
https://www.gnome-look.org/p/1460400
https://www.gnome-look.org/p/1403328
```

下载美化资源后，解压复制到以下地方即可

```bash
主题存放目录 : ~/.local/share/themes 或 ~/.themes
图标存放目录 : ~/.local/share/icons 或 ~/.icons
字体存放目录 : ~/.local/share/fonts 或 ~/.fonts
```

### conky

`vim ~/.scripts/conky.sh` # 编辑此文件

修改配置文件路径

```bash
conky -c ~/.config/conky/shortcuts &&    # 修改为你的conkyrc存放位置
conky -c ~/.config/conky/system &&       # 修改为你的conkyrc存放位置
```


### grub 美化

修改grub文件
`sudo vim  /etc/default/grub`

```bash
GRUB_TIMEOUT_STYLE=hide        # 修改为 menu，开机显示grub引导画面
GRUB_TIMEOUT=15                # 修改为 5
GRUB_DISABLE_RECOVERY=true     # 修改为 false
```

**最后更新 grub !!!**

`sudo update-grub`

**也可以使用别人写好的脚本美化**

```bash
从下面的链接下载文件，然后执行，并重启即可

git clone https://github.com/vinceliuice/grub2-themes.git

sudo ./install.sh -t       # install Tela theme
sudo ./install.sh -r -t    # Remove Tela theme
```

## 最后一步

打开 `manjaro setting`

1. 配置自动同步时间选项(不然 v2ray 无法使用)
2. 安装语言包
3. 然后修改系统语言为中文！(如果你选择英文安装系统的话)

重启系统！


##  其他

### 修改目录名为英文

安装 xdg-user-dirs-gtk

`sudo pacman -S xdg-user-dirs-gtk`

安装完成后，在终端依次执行下面的命令：

```bash
export LANG=en_US
xdg-user-dirs-gtk-update # 执行完这步，会弹出来一个对话框，选择更新即可
export LANG=zh_CN.UTF-8
```

命令执行完成后注销或重启系统，再次登录系统时会提醒你修改目录名，选择否即可！

---


### Npm

`sudo pacman -S npm`

npm源配置

```
查看当前镜像源
npm get registry

设置镜像源
npm config set registry https://registry.npmmirror.com
```
