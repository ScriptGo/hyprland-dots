# 参考: 从零开始配置 HyprLand

## 验证引导模式

要验证系统目前的引导模式，请检查 UEFI 位数：

```bash
cat /sys/firmware/efi/fw_platform_size
```

- 如果命令结果为 64，则系统是以 UEFI 模式引导且使用 64 位 x64 UEFI
- 如果命令结果为 32，则系统是以 UEFI 模式引导且使用 32 位 IA32 UEFI，虽然其受支持，但引导加载程序只能使用 systemd-boot
- 如果文件不存在，则系统可能是以BIOS模式（或 CSM 模式）引导

## 无线连接

确保系统已经列出并启用了网络接口

```
ip link # 列出网络接口信息
```

请确保网卡未被 rfkill 禁用，使用下面的命令查看

```
rfkill list # yes 表示被禁用
```

启用 `wlan0` 接口

```
ip link set wlan0 up
```

若看到类似 Operation not possible due to RF-kill 的报错，尝试使用下面的命令来解锁无线网卡。

```bash
rfkill unblock wifi
```

使用 `iwctl` 配置无线连接

```bash
# 进入交互模式
iwctl
# 列出无线网卡的设备名, 比如 wlan0
device list
# 扫描无线网络 
station wlan0 scan
# 列出所有无线网络
station wlan0 get-networks
# SSID连接无线网络，SSID代表无线的名称，回车后输入密码即可
station wlan0 connect
# 连接成功后退出
exit
```

### 测试网络连通

通过 ping 命令测试网络连通性：

`ping -c 3 www.archlinux.org`

稍等片刻，若能看到数据返回，说明已经联网。

## 更新系统时钟

将系统时间与网络时间进行同步

`timedatectl set-ntp true`

查看服务状态

`timedatectl status`

## 分区

### 硬盘命名

| 硬盘类型 | 命名形式 | 备注  |
| --- | --- | --- |
| 固态硬盘(SSD) | nvmexnxpx | x 表示数字 |

- nvme0n1p2 :
  - 0 : 代表控制器编号
  - n1 : 表示此控制器下的第1块硬盘
  - p2 : 表示此控制器下的第1块硬盘的第2个分区

### 分区参考

| 硬盘分区 | 对应的系统分区 |
| --- | --- |
| nvme0n1p1 | efi |
| nvme0n1p2 | swap |
| nvme0n1p3 | /   |
| nvme0n1p4 | home |

**使用 `cfdisk` 命令对磁盘分区**

`cfdisk /dev/硬盘类型`

==如果是新硬盘，会提示你选择硬盘分区表的类型(GPT 或 MBR)==

分区步骤

```bash
1. 选中 Free space > 再选中操作 [New] > 然后按下回车 Enter 以新建分区

2. 输入 分区大小, 然后按下回车 Enter

3. 选中操作 [Type] > 然后按下回车 Enter, 通过方向键 ↑ 和 ↓ 选中区分的文件类型，最后按下回车 Enter

4. 依照顺序创建其它分区
5.磁盘分区完成后记得，选择 write, 回车输入 yes 再回车将分区信息写入分配表中
```

分区结束后， 复查磁盘情况

`fdisk -l` 或 `lsblk`

### 格式化磁盘

1. EFI 分区  
    `mkfs.fat -F 32 /dev/nvme0n1p1`

2. 交换分区  
    `mkswap /dev/nvme0n1p2`

3. 系统分区  
    `mkfs.ext4 /dev/nvme0n1p3`

4. home 分区  
    `mkfs.ext4 /dev/nvme0n1p4`

## 挂载分区

`先挂载根分区，再挂载 EFI 分区!`

1. 挂载根分区  
    `mount /dev/nvme0n1p3 /mnt`

2. 挂载EFI分区  
    `mount --mkdir /dev/nvme0n1p1 /mnt/boot`

3. 挂载交换分区  
    `swapon /dev/nvme0n1p2`

4. 挂载home分区  
    `mount --mkdir /dev/nvme0n1p4 /mnt/home`

## 镜像源

禁用 reflector
`systemctl stop reflector.service`

通过以下命令查看该服务是否被禁用
`systemctl status reflector.service`
按 q 退出输出

使用 nano 编辑 `/etc/pacman.d/mirrorlist`文件，添加以下内容:

```bash
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch

# 一些较为优质的国际源
Server = https://mirror.archlinux.tw/ArchLinux/$repo/os/$arch
Server = https://mirrors.cat.net/archlinux/$repo/os/$arch
Server = https://mirror.aktkn.sg/archlinux/$repo/os/$arch
```

## 安装基础包

`pacstrap -K /mnt base base-devel linux linux-headers linux-firmware`

必需的功能性软件

```bash
pacstrap -K /mnt networkmanager network-manager-applet dhcpcd iwd zsh git openssh man-db man-pages man-pages-zh_cn neovim
```

## 生成 fstab 文件

fstab 用来定义磁盘分区

`genfstab -U /mnt >> /mnt/etc/fstab`

复查一下 /mnt/etc/fstab 确保没有错误

`cat /mnt/etc/fstab`

## change root

把环境切换到新系统的/mnt 下

`arch-chroot /mnt`

## 时区设置

`ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`

将当前的正确 UTC 时间写入硬件时间

`hwclock --systohc`

## 本地化

编辑 /etc/locale.gen，去掉下面两行前面的 `#`

```bash
 en_US.UTF-8
 zh_CN.UTF-8 
```

然后使用如下命令生成 locale

`locale-gen`

向 /etc/locale.conf 导入内容

`echo 'LANG=zh_CN.UTF-8' > /etc/locale.conf`

## 设置主机名

首先在/etc/hostname设置主机名
`nvim /etc/hostname`

接下来在/etc/hosts设置与其匹配的条目
`nvim /etc/hosts`

加入如下内容

```bash
127.0.0.1   localhost
::1       localhost
127.0.1.1   Pluto.localdomain    localhost
```

## 设置 root 用户密码

`passwd root`

## 微码

`pacman -S intel-ucode`

## 引导程序

```bash
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```

接下来编辑 `/etc/default/grub` 文件，找到下面这行：

`GRUB_CMDLINE_LINUX_DEFAULT`

- 去掉 quiet 参数，
- 把 log level 的数值从 3 改成 5。这样是为了后续如果出现系统错误，方便排错。
- 再加入 nowatchdog 参数，这可以显著提高开关机速度。

最后生成 GRUB 所需的配置文件

`grub-mkconfig -o /boot/grub/grub.cfg`

## 完成安装

1. 退回安装环境  
    `exit`

2. 卸载新分区  
    `umount -R /mnt`

3. 重启并拔掉U盘  
    `reboot`

## 配置

1.配置网络服务

使用 `root` 用户登录系统后，先开启以下服务：

```bash
systemctl enable NetworkManager
systemctl enable dhcpcd
systemctl enable sshd
```

`重启系统以便上面的服务生效`

2.使用无线网连接网络

登录系统后使用 nmcli 连接网络：
`nmcli dev wifi connect 无线网 password "网络密码"`

3.测试网络

通过 ping 命令测试网络连通性:  
`ping -c 3 www.archlinux.org`

稍等片刻，若能看到数据返回，说明已经联网。

4.创建用户

`useradd -m -G wheel <用户名>`

设置用户密码

`passwd <用户名>`

5.设置用户权限

`EDITOR=nvim visudo /etc/sudoers`

找到

```bash
# Uncomment to allow members of group wheel to execute any command
#%wheel ALL=(ALL:ALL) ALL` 
```

去掉 `%wheel` 前面的 #

6.配置pacman

修改 `/etc/pacman.conf`

**启用 `[multilib]`**

去掉下面两行前面的 `#`

```bash
#[multilib]
#Include = /etc/pacman.d/mirrorlist
```

**启用 `[archlinuxcn]`**

在文件的最下面加入以下内容：

```bash
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

彩蛋

```bash
去掉这几行前面的 #
#Color
#CHeckSpace
#VerbosePkgLists
#ParallelDownloads = 5 

# 再加入这一行
ILoveCandy
```

更新源

`pacman -Syyu`

导入密钥

```bash
pacman-key --lsign-key "<farseerfc@archlinux.org>"
pacman -S archlinuxcn-keyring
```

## 字体

`pacman -S terminus-font noto-fonts noto-fonts-cjk noto-fonts-emoji`

## 音频

| Type | Package(s) |
| --- | --- |
| 音频服务 | pacman -S pipewire wireplumber |
| 音频客户端 | pacman -S pipewire-jack pipewire-alsa pipewire-pulse |

## 蓝牙

| Type | Package(s) | 备注  |
| --- | --- | --- |
| 蓝牙  | pamcan -S bluez bluez-utils blueman | systemctl enable bluetooth |

## 显卡

每个人的硬件环境都不一样，这里以我的联想拯救者笔记本为例，我的显卡是 Nvidia 的 RTX4060。

1.安装

较新型号的独立显卡直接安装如下几个包即可

`pacman -S nvidia nvidia-settings lib32-nvidia-utils`

2.编辑 `etc/default/grub` 文件

将下面的内容添加到`GRUB_CMDLINE_LINUX_DEFAULT`中

`nvidia_drm.modeset=1`

然后运行

`grub-mkconfig -o /boot/grub/grub.cfg`

3.编辑 `/etc/mkinitcpio.conf` 文件

找到 `MODULES` 这行，添加以下内容

`nvidia nvidia_modeset nvidia_uvm nvidia_drm`

找到 `HOOKS` 这一行，删除其中的 `kms`

然后运行

`mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img`

4.编辑 `/etc/modprobe.d/nvidia.conf` 文件

添加以下内容

`options nvidia-drm modeset=1`

5.为了避免更新 NVIDIA 驱动之后忘了更新 initramfs，执行下面命令新建 nvidia.hook 钩子：

先创建一个 `hooks` 目录
`mkdir /etc/pacman.d/hooks`

再创建 `nvidia.hook`文件
`nvim /etc/pacman.d/hooks/nvidia.hook`

在`nvidia.hook`文件内，加入以下内容:

```bash
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
```

**注意，Target 中，linux内核的版本要和nvidia的版本要一致。**

如果你使用的是lts的内核，那么nvidia也要使用lts版的!

6.重启系统

使用普通用户，登录系统

## HyprLand

1.先更新下系统

`sudo pacman -Syyu`

2.安装 hyprland

`sudo pacman -S hyprland`

3.安装 qt-wayland 支持

`sudo pacman -S qt5-wayland qt6-wayland glfw-wayland`

4.XDP支持

`sudo pacman -S xdg-desktop-portal-hyprland xdg-desktop-portal-gtk`

5.用户目录管理

`sudo pacman -S xdg-user-dirs-gtk`

6.

| Type | Package(s) | 备注  |
| --- | --- | --- |
| waybar | sudo pacman -S waybar |     |
| 通知 | sudo pacman -S dunst |     |
| 认证 | sudo pacman -S polkit-gnome |     |
| 终端 | sudo pacman -S kitty |     |
| 登录管理器 | sudo pacman -S sddm | sudo systemctl enable sddm |

**备注列的内容需要在软件安装完成后执行**

## 文件管理

| Type | Package(s) | 备注  |
| --- | --- | --- |
| 文件管理器 | sudo pacman -S pcmanfm-gtk3 gvfs |     |
| PDF阅读器 | sudo pacman -S zathura zathura-pdf-poppler |     |
| 解压缩 | sudo pacman -S file-roller p7zip unrar |     |

## 软件管理

| Type | Package(s) | 备注  |
| --- | --- | --- |
| AUR 助手 | sudo pacman -S yay |  |
| 启动器 | yay -S rofi-lbonn-wayland |     |

## 字体

| 字体 | 安装 |
| ---- | ---- |
| Sarasa | sudo pacman -S ttf-sarasa-gothic |
| | sudo pacman -S ttf-fira-code ttf-jetbrains-mono |
| Nerd | sudo pacman -S ttf-firacode-nerd ttf-jetbrains-mono-nerd |
| 图标 | sudo pacman -S awesome-terminal-fonts otf-font-awesome |
| material icons | yay -S ttf-material-design-icons-webfont |

刷新字库

`fc-cache -f -v`

## TRIM

TRIM 会帮助清理 SSD 中的块，从而延长 SSD 的使用寿命。

`sudo systemctl enable fstrim.timer`

## 电源管理

`sudo pacman -S tlp`

配置

`sudo systemctl enable tlp`

## Misc

| Type | Package(s) | 备注  |
| --- | --- | --- |
| 编辑器 | yay -S visual-studio-code-bin |     |
| 磁盘管理 | sudo pacman -S gparted |     |
| 启动盘制作 | sudo pacman -S ventoy |     |
| 防火墙 | sudo pacman -S gufw | sudo ufw enable |
| 笔记  | sudo pacman -S joplin-desktop |     |
| 字体管理器 | sudo pacman -S font-manager |     |
| 办公软件 | sudo pacman -S libreoffice libreoffice-fresh-zh-cn | 直接回车或选择 [1] |
| 科学上网 | sudo pacman -S v2raya |     |
| 浏览器 | yay - S google-chrome |     |
| 文本编辑器 | sudo pacman -S neovide | sudo pacman -s python-pynvim |
| 剪贴板 | sudo pacman -S cliphist | |
| 截图 | sudo pacman -S grim slurp | |

## CLI

| Type | Package(s) | 备注  |
| --- | --- | --- |
| 网络工具 | sudo pacman -S net-tools |     |
| 替代curl | sudo pacman -S httpie |     |
| 显示系统信息 | sudo pacman -S neofetch btop |     |
| 娱乐工具 | sudo pacman -S fortune-mod cowsay sl cmatrix |     |
| 替换 find | sudo pacman -S fd |     |
| 替换 grep | sudo pacman -S ripgrep |     |
| 替换 cat | sudo pacman -S bat |     |
| 流程图 | sudo pacman -S graphviz |     |
| 简化版 man 手册 | sudo pacman -S tldr | `第一次使用tldr之前，需要更新一下缓存 tldr --update` |
| 模糊查找 | sudo pacman -S fzf |     |
| shellcheck | sudo pacman -S shellcheck | |
| 其他  | sudo pacman -S zenity tree lolcat |     |

**到此，就可以重启系统了**

以下的操作，可以进入桌面进行了

## zsh

1.切换shell为zsh

`chsh -s $(which zsh)`

`注销或重启后生效`

2.常用插件

| 插件  |     |
| --- | --- |
| 自动建议 | sudo pacman -S zsh-autosuggestions |
| 语法高亮 | sudo pacman -S zsh-syntax-highlighting |
| 历史命令搜索 | sudo pacman -S zsh-history-substring-search |
| 快速跳转 | yay -S zsh-z-git |

3.提示符美化

`sudo pacman -S starship`

## 多媒体

| Type | Package(s) | 备注  |
| --- | --- | --- |
| 图片浏览 | sudo pacman -S tumbler viewnior |     |
| 图片编辑 | sudo pacman -S imagemagick gimp inkscape |     |
| 解码工具 | sudo pacman -S ffmpeg ffmpegthumbnailer |     |
| 播放器 | sudo pacman -S mpv |     |
| 音频管理 | sudo pacman -S pamixer pavucontrol |     |
| 播放器 | sudo pacman -S mpd mpc ncmpcpp |     |
| 音频可视化 | sudo pacman -S cava |
| 录屏 | sudo pacman -S obs-studio |     |

mpd配置

```bash
systemctl start mpd.service --user  # 启动 mpd 服务
systemctl enable mpd.service --user # 开机自启
```

## 美化

### 工具

| Type | Package(s) | 备注  |
| --- | --- | --- |
| GTK | sudo pacman -S nwg-look | |
| QT  | sudo pacman -S kvantum qt5ct |     |
| 壁纸切换 | sudo pacman -S swww |     |
| 锁屏  | sudo pacman -S swaylock-effects |     |
| 空闲管理 | sudo pacman -S swayidle |     |

### 主题

1.从源中安装

`sudo pacman -S papirus-icon-theme mojave-gtk-theme-git`

2.手动安装

2.1 下载网址

```bash
https://github.com/vinceliuice/WhiteSur-icon-theme
https://github.com/vinceliuice/WhiteSur-gtk-theme
```

2.2 下载美化资源后，解压复制到以下地方即可

```bash
主题存放目录 : ~/.local/share/themes 或 ~/.themes
图标(光标)存放目录 : ~/.local/share/icons 或 ~/.icons
字体存放目录 : ~/.local/share/fonts 或 ~/.fonts
```

亦可使用文件中提供的脚本进行安装

### grub 美化

1. 使用脚本安装

克隆下面这个仓库并切换到 `grub2-themes` 目录

`git clone https://github.com/vinceliuice/grub2-themes.git && grub2-themes`

然后执行

```bash
sudo ./install.sh -t       # install Tela theme
```

2.手动安装

2.1. 克隆下面这个仓库并切换到 `grub` 目录

`git clone https://github.com/catppuccin/grub.git && cd grub`

2.2. 复制 `src` 目录内的所有文件至 `/usr/share/grub/themes/`

`sudo cp -r src/* /usr/share/grub/themes/`

2.3. 编辑 `/etc/default/grub` 文件

找到 `GRUB_THEME` 这行，修改为以下任意主题

**latte:**

```bash
GRUB_THEME="/usr/share/grub/themes/catppuccin-latte-grub-theme/theme.txt"
```

**potted_plant Frappé:**

```bash
GRUB_THEME="/usr/share/grub/themes/catppuccin-frappe-grub-theme/theme.txt"
```

**hibiscus Macchiato:**

```bash
GRUB_THEME="/usr/share/grub/themes/catppuccin-macchiato-grub-theme/theme.txt"
```

**herb Mocha:**

```bash
GRUB_THEME="/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt"
```

2.4. 更新 grub:

`sudo grub-mkconfig -o /boot/grub/grub.cfg`

### sddm

1.安装主题

`yay -S sddm-sugar-candy-git sddm-theme-corners-git sddm-theme-sugar-candy-git`

2.配置文件 :

`sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf`

3.查看已安装的主题 :

`ls /usr/share/sddm/themes`

4.编辑 `/etc/sddm.conf`文件

找到 `theme` 字段，修改为想要的主题即可
