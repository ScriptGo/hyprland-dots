# HyprlandWM

## 安装

### hyprland

1.更新系统

`sudo pacman -Syyu`

2.安装 hyprland

`sudo pacman -S hyprland`

3.qt-wayland 支持

`sudo pacman -S qt5-wayland qt6-wayland glfw-wayland`

4.XDP 支持

`sudo pacman -S xdg-desktop-portal-hyprland xdg-desktop-portal-gtk`

5.用户目录管理

`sudo pacman -S xdg-user-dirs-gtk`

6.配套软件

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| waybar | sudo pacman -S waybar |     |
| 通知 | sudo pacman -S dunst |     |
| 认证 | sudo pacman -S polkit-gnome |     |
| 终端 | sudo pacman -S kitty |     |
| 登录管理器 | sudo pacman -S sddm | sudo systemctl enable sddm |
| AUR 助手 | sudo pacman -S yay |  |

### 文件管理

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| 文件管理器 | sudo pacman -S pcmanfm-gtk3 gvfs |     |
| PDF阅读器 | sudo pacman -S zathura zathura-pdf-poppler |     |
| 解压缩 | sudo pacman -S file-roller p7zip unrar |     |

### 字体

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| Sarasa | sudo pacman -S ttf-sarasa-gothic | |
| 英文字体 | sudo pacman -S ttf-fira-code ttf-jetbrains-mono | |
| Nerd | sudo pacman -S ttf-firacode-nerd ttf-jetbrains-mono-nerd | |
| 图标 | sudo pacman -S awesome-terminal-fonts otf-font-awesome | |

### Misc

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| 启动器 | sudo pacman -S rofi-wayland |     |
| 防火墙 | sudo pacman -S gufw | sudo ufw enable |
| 笔记软件 | sudo pacman -S joplin-desktop |     |
| 字体管理 | sudo pacman -S font-manager |     |
| 办公软件 | sudo pacman -S libreoffice-fresh libreoffice-fresh-zh-cn | |
| 科学上网 | sudo pacman -S v2raya |     |
| 浏览器 | yay - S google-chrome |     |
| 编辑器 | yay -S visual-studio-code-bin | |
| 剪贴板 | sudo pacman -S cliphist | |
| 截图 | sudo pacman -S grim slurp | |

### CLI

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| 网络工具 | sudo pacman -S net-tools |     |
| 替代curl | sudo pacman -S httpie |     |
| 显示系统信息 | sudo pacman -S btop |     |
| 娱乐工具 | sudo pacman -S fortune-mod cowsay sl cmatrix |     |
| 替换 find | sudo pacman -S fd |     |
| 替换 grep | sudo pacman -S ripgrep |     |
| 替换 cat | sudo pacman -S bat |     |
| 简化版 man 手册 | sudo pacman -S tldr | `第一次使用tldr之前，需要更新一下缓存 tldr --update` |
| 模糊查找 | sudo pacman -S fzf |     |
| shellcheck | sudo pacman -S shellcheck | |
| 其他  | sudo pacman -S jq zenity tree lolcat |     |

### 多媒体

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| 图片浏览 | sudo pacman -S tumbler viewnior |     |
| 图片编辑 | sudo pacman -S imagemagick gimp inkscape |     |
| 解码工具 | sudo pacman -S ffmpeg ffmpegthumbnailer |     |
| 播放器 | sudo pacman -S mpv |     |
| 音频管理 | sudo pacman -S pamixer pavucontrol |     |
| 播放器 | sudo pacman -S mpd mpc ncmpcpp |     |
| 音频可视化 | sudo pacman -S cava | |
| 录屏 | sudo pacman -S obs-studio |     |

## 配置

### 家目录改名

打开终端执行下面的命令

```bash
export LANG=en_US.UTF-8
xdg-user-dirs-gtk-update
export LANG=zh_CN.UTF-8
```

注销或重启后生效

### zsh

1.切换shell

`chsh -s $(which zsh)`

注销或重启后生效

2.常用插件

| 插件  |     |
| --- | --- |
| 自动建议 | sudo pacman -S zsh-autosuggestions |
| 语法高亮 | sudo pacman -S zsh-syntax-highlighting |
| 历史命令搜索 | sudo pacman -S zsh-history-substring-search |
| 快速跳转 | yay -S z.lua |

3.提示符美化

`sudo pacman -S starship`

### mpd

```bash
systemctl start mpd.service --user  # 启动 mpd 服务
systemctl enable mpd.service --user # 开机自启
```

### 缓存

自动清理不使用的软件包缓存

```bash
sudo pacman -S pacman-contrib
sudo systemctl enable paccache.timer
```

### SSD

TRIM 会帮助清理 SSD 中的块，从而延长 SSD 的使用寿命。

`sudo systemctl enable fstrim.timer`

### TLP

电源管理

```bash
sudo pacman -S tlp
sudo systemctl enable tlp
```
