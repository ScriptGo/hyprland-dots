<div align="center"> <h1> ArchLinux 配置参考 </h1>  </div>



- 已安装好干净的 ArchLinux 环境
- 镜像源已经配置好
- 必要的软件已安装(NetworkManager, openssh, vim, git, zsh等)



**1. 配置网络**

使用 `root` 用户登录系统后，先开启以下服务：

```
systemctl enable NetworkManager
systemctl enable dhcpcd
systemctl enable sshd
```

==重启系统以便上面的服务生效==

**1.1 使用宽带连接网络(略)**

**1.2 使用无线网连接网络**

登录系统后使用 nmcli 连接网络：

显示附近的 Wi-Fi 网络  
`nmcli dev wifi list`  

连接无线网络  
`nmcli dev wifi connect SSID password "网络密码"` 

**1.3 测试网络**

通过 ping 命令测试网络连通性:  
`ping -c 3 www.archlinux.org`

稍等片刻，若能看到数据返回，说明已经联网。

**2. 创建用户**

`useradd -m -G wheel <用户名>`

**2.1 设置用户密码**

`passwd <用户名>`

**2.2 设置用户权限**

编辑 sudoers 文件

`EDITOR=vim visudo /etc/sudoers`

找到  
```
# Uncomment to allow members of group wheel to execute any command
#%wheel ALL=(ALL:ALL) ALL` 
```

去掉 `%wheel ` 前面的 #


**3. 配置 pacman.conf**

文件位置: `/etc/pacman.conf`

**3.1 启用 `[multilib]`**

去掉下面两行前面的 `#`
```
#[multilib]
#Include = /etc/pacman.d/mirrorlist
```

**3.2 启用 `[archlinuxcn]`**

在文件的最下面加入以下内容：

```
[archlinuxcn]

Server = https://mirrors.bfsu.edu.cn/archlinuxcn/$arch

# Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

**3.3  彩蛋**

找到 `# Misc options`

```
去掉这几行前面的 #
#Color
#CHeckSpace
#VerbosePkgLists
#ParallelDownloads = 5 

# 再加入这一行
ILoveCandy
```

**3.4 更新源**

`pacman -Syy`

**3.5 导入密钥**

`pacman -S archlinuxcn-keyring`

**3.6 清理软件包缓存**

安装 pacman-contrib ，然后开机自动启动 paccache.timer，以便每周自动清理不使用的软件包缓存。

```
pacman -S pacman-contrib
systemctl enable paccache.timer
```



## 字体

**基础字体**

`pacman -S notot-fonts noto-fonts-cjk noto-fonts-emoji`



## 音频

| Type     | Package(s)                                      | 备注 |
| -------- | ----------------------------------------------- | ---- |
| 音频服务 | pacman -S pipewire pipewire-alsa pipewire-pulse |      |



## 蓝牙

| Type | Package(s)                          | 备注                            |
| ---- | ----------------------------------- | ------------------------------- |
| 蓝牙 | pamcan -S bluez bluez-utils blueman | sudo systemctl enable bluetooth |



## 显卡



### Intel 核显

英特尔核芯显卡安装如下几个包即可。

`pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel`



### NVIDIA 独显

较新型号的独立显卡直接安装如下几个包即可(我的显卡型号是 : GTX 1050Ti)

`pacman -S nvidia nvidia-settings lib32-nvidia-utils`   #必须安装



### Intel 核显 + NVIDIA 独显



**不起作用，可忽略这步**




若为同时拥有核芯显卡与英伟达独显的笔记本电脑，同样需要按照上述步骤先安装各个软件包。除此之外还需要安装 optimus-manager。可以在核芯显卡和独立显卡间轻松切换。optimus-manager 提供三种模式，分别为仅用独显，仅用核显，和 hybrid 动态切换模式。

`yay -S optimus-manager optimus-manager-qt`

安装完成后重启即可使用。optimus-manager 安装完成后会默认 enable optimus-manager 的服务，你可在重启前检查其状态，若没有 enable 则手动将其 enable。重启后在菜单栏搜索 optimus-manager 点击即可使用。可在其设置中设置开机自动启动。

`systemctl enable optimus-manager`



**直接执行这些操作!!!**


1. 编辑 ==/etc/default/grub== 文件。将下面的内容添加到`GRUB_CMDLINE_LINUX_DEFAULT`中

`nvidia_drm.modeset=1`

然后运行

`grub-mkconfig -o /boot/grub/grub.cfg `


2. 编辑 ==/etc/mkinitcpio.conf== 文件

找到 `MODULES` 这行，添加以下内容

`nvidia nvidia_modeset nvidia_uvm nvidia_drm`

找到 `HOOKS` 这一行，删除其中的 `kms`

然后运行

`mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img`


3. 编辑 ==/etc/modprobe.d/nvidia.conf== 文件

添加以下内容

`options nvidia-drm modeset=1`

4. 为了避免更新 NVIDIA 驱动之后忘了更新 initramfs，执行下面命令新建 nvidia.hook 钩子：

`mkdir /etc/pacman.d/hooks`

`vim /etc/pacman.d/hooks/nvidia.hook`

```
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

务必保证 Target 项所设置的软件包与你在前面的安装过程中所使用的相符（例如nvidia 或 nvidia-dkms 或 nvidia-lts 或 nvidia-ck-something）。

**AMD显卡安装请参考ArchWiki**


6. 重启系统





<div align="center"> <h1> HyprLand 配置参考 </h1>  </div>



==用普通用户登录系统==



**连接网络**

显示附近的 Wi-Fi 网络  
`nmcli dev wifi list`  

连接无线网络  
`nmcli dev wifi connect SSID password "网络密码"` 



**测试网络**

通过 ping 命令测试网络连通性：
`ping -c 3 www.archlinux.org`

稍等片刻，若能看到数据返回，说明已经联网。



**更新系统**

首先更新下系统

sudo pacman -Syyu`



## 安装 hyprland

`sudo pacman -S hyprland`



## 安装 qt-wayland 支持

`sudo pacman -S qt5-wayland qt6-wayland glfw-wayland`



## 用户目录管理

`sudo pacman -S xdg-user-dirs xdg-user-dirs-gtk`



## 配套

| Type       | Package(s)                         | 备注                       |
| ---------- | ---------------------------------- | -------------------------- |
| waybar     | sudo pacman -S waybar-hyprland-git |                            |
| 通知程序   | sudo pacman -S dunst               |                            |
| 认证代理   | sudo pacman -S polkit-gnome        |                            |
| 终端       | sudo pacman -S kitty          |                 |
| 锁屏       | sudo pacman -S swaylock-effects    |                            |
| 空闲管理   | sudo pacman -S swayidle            |                            |
| 登录管理器 | sudo pacman -S sddm-git            | sudo systemctl enable sddm |

**备注列的内容需要在软件安装完成后执行**



## 文件管理

| Type                 | Package(s)                                 | 备注 |
| -------------------- | ------------------------------------------ | ---- |
| 文件管理器           | sudo pacman -S pcmanfm-gtk3                |      |
| 虚拟文件系统(回收站) | sudo pacman -S gvfs                        |      |
| 自动挂载可移动磁盘   | sudo pacman -S udiskie                     |      |
| PDF阅读器            | sudo pacman -S zathura zathura-pdf-poppler |      |
| 解压缩               | sudo pacman -S file-roller p7zip unrar     |      |



**到此，就可以重启系统了**

以下的操作，可以进入桌面进行了。



## 软件管理

| Type     | Package(s)           | 备注 |
| -------- | -------------------- | ---- |
| 软件管理 | sudo pacman -S pamac |      |
| AUR 助手 | sudo pacman -S yay   |      |
| 启动器     | yay -S rofi-lbonn-wayland-git |                 |

执行以下命令修改 aururl :

 `yay --aururl "https://aur.archlinux.org" --save` # ==请换成国内的源==

配置文件位于 ~/.config/yay/config.json



## 字体

**1. 中文**

```bash
sudo pacman -S ttf-sarasa-gothic
```

**2. 英文**

```bash
sudo pacman -S ttf-fira-code ttf-jetbrains-mono
```

**3. Nerd**

```bash
sudo pacman -S ttf-firacode-nerd ttf-jetbrains-mono-nerd
```

**4. 图标**

```bash
sudo pacman -S awesome-terminal-fonts otf-font-awesome
```

**5. material icons**

`yay -S ttf-material-design-icons-webfont`

**6. 刷新字库**

`fc-cache -f -v`



## TRIM

TRIM 会帮助清理 SSD 中的块，从而延长 SSD 的使用寿命。

`sudo systemctl enable fstrim.timer`



## Misc

| Type       | Package(s)                    | 备注            |
| ---------- | ----------------------------- | --------------- |
| MD编辑器   | sudo pacman -S typora         |                 |
| 磁盘管理   | sudo pacman -S gparted        |                 |
| 启动盘制作 | sudo pacman -S ventoy         |                 |
| 防火墙     | sudo pacman -S gufw           | sudo ufw enable |
| 笔记       | sudo pacman -S joplin-desktop |                 |
| 字体管理器 | sudo pacman -S font-manager   |                 |
| 办公软件   | sudo pacman -S libreoffice    | 选择 [1]        |
| 系统备份   | sudo pacman -S timeshift      |                 |
| 图片处理   | sudo pacman -S gimp inkscap   |                 |
| 科学上网   | sudo pacman -S v2ray-desktop  |                 |
| 浏览器     | yay -S google-chrome          |                 |



## CLI

| Type                   | Package(s)                                   | 备注                                                 |
| ---------------------- | -------------------------------------------- | ---------------------------------------------------- |
| 网络工具               | sudo pacman -S net-tools                     |                                                      |
| 替代curl               | sudo pacman -S httpie                        |                                                      |
| 显示系统信息           | sudo pacman -S neofetch btop                 |                                                      |
| 娱乐工具               | sudo pacman -S fortune-mod cowsay sl cmatrix |                                                      |
| 替换 find              | sudo pacman -S fd                            |                                                      |
| 替换 grep              | sudo pacman -S ripgrep                       |                                                      |
| 替换 cat               | sudo pacman -S bat                           |                                                      |
| 命令行下查看 json 文件 | sudo pacman -S jq                            |                                                      |
| 流程图                 | sudo pacman -S graphviz                      |                                                      |
| 简化版 man 手册        | sudo pacman -S tldr                          | `第一次使用tldr之前，需要更新一下缓存 tldr --update` |
| 模糊查找               | sudo pacman -S fzf                           |                                                      |
| 其他                   | sudo pacman -S zenity tree lolcat            |                                                      |



## zsh

1. 切换shell为zsh

`chsh -s $(which zsh)`

==注销或重启后生效==

2. 常用插件

| 插件         |                                             |
| ------------ | ------------------------------------------- |
| 自动建议     | sudo pacman -S zsh-autosuggestions          |
| 自动补全     | sudo pacman -S zsh-completions              |
| 语法高亮     | sudo pacman -S zsh-syntax-highlighting      |
| 历史命令搜索 | sudo pacman -S zsh-history-substring-search |
| 快速跳转     | yay -S zsh-z-git                            |

3. 提示符美化

`sudo pacman -S starship`



## 多媒体

| Type       | Package(s)                               | 备注 |
| ---------- | ---------------------------------------- | ---- |
| 图片浏览   | sudo pacman -S tumbler viewnior          |      |
| 图片编辑   | sudo pacman -S imagemagick gimp inkscape |      |
| 解码工具   | sudo pacman -S ffmpeg ffmpegthumbnailer  |      |
| 播放器     | sudo pacman -S mpv                       |      |
| 音频管理   | sudo pacman -S pamixer pavucontrol       |      |
| 播放器     | sudo pacman -S mpd mpc ncmpcpp           |      |
| 音频可视化 | sudo pacman -S cava                      |      |


mpd 配置

复制配置文件到 ~/.config 目录下

之后把 mpd 和 ncmpcpp 配置里面的音乐目录改成你的音乐路径即可

```
systemctl start mpd.service --user  # 启动 mpd 服务
systemctl enable mpd.service --user # 开机自启
```

出现问题之后首先检查mpd的日志

`systemctl status mpd --user`

根据不同的提示来解决问题



## 输入法

请参考 `https//github.com/ScriptGo/rime`



## 语言包

==纯英文环境可以忽略这步==

| Type       | Package(s)                             | 备注 |
| ---------- | -------------------------------------- | ---- |
| gime       | sudo pacman -S gimp-help-zh_cn         |      |
| man-pages  | sudo pacman -S man-pages-zh_cn         |      |
| libreffice | sudo pacman -S libreoffice-fresh-zh-cn |      |



## 美化

### 资源

下载美化资源后，解压复制到以下地方即可

```bash
主题存放目录 : ~/.local/share/themes 或 ~/.themes
图标(光标)存放目录 : ~/.local/share/icons 或 ~/.icons
字体存放目录 : ~/.local/share/fonts 或 ~/.fonts
```

### 设置

| Type     | Package(s)                    | 备注 |
| -------- | ----------------------------- | ---- |
| GTK      | yay -S nwg-look               |      |
| QT       | sudo pacman -S  kvantum qt5ct |      |
| 壁纸切换 | yay -S swww                   |      |


### grub 美化

1. 使用脚本

克隆下面这个仓库并切换到 `grub2-themes` 目录

`git clone https://github.com/vinceliuice/grub2-themes.git && grub2-themes`

然后执行

```bash
sudo ./install.sh -t       # install Tela theme
```

2. 手动安装

2.1. 克隆下面这个仓库并切换到 `grub` 目录

`git clone https://github.com/catppuccin/grub.git && cd grub`

2.2. 复制 `src` 目录内的所有文件至 `/usr/share/grub/themes/`

`sudo cp -r src/* /usr/share/grub/themes/`

2.3. 编辑 `/etc/default/grub` 文件

找到 ==GRUB_THEME==这行，修改为以下任意主题

**latte:**
```
GRUB_THEME="/usr/share/grub/themes/catppuccin-latte-grub-theme/theme.txt"
```

**potted_plant Frappé:**
```
GRUB_THEME="/usr/share/grub/themes/catppuccin-frappe-grub-theme/theme.txt"
```

**hibiscus Macchiato:**
```
GRUB_THEME="/usr/share/grub/themes/catppuccin-macchiato-grub-theme/theme.txt"
```

**herb Mocha:**
```
GRUB_THEME="/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt"
```

2.4. 更新 grub:

`sudo grub-mkconfig -o /boot/grub/grub.cfg`


### conky

### sddm

配置文件 :

`sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf`

查看已安装的主题 : `ls /usr/share/sddm/themes`

编辑 `/etc/sddm.conf`   找到  `theme` 字段，修改为想要的主题即可



## 开发

**1. java**

`sudo pacman -S jre17-openjdk`

**2. npm**

`sudo pacman -S npm`

npm源配置

```
npm config set registry https://registry.npmmirror.com
```

