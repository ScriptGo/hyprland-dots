# 桌面环境

我使用的是窗口管理器，不是完整的桌面环境！

## Hyprland

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

## 文件管理

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| 文件管理器 | sudo pacman -S pcmanfm-gtk3 gvfs |     |
| PDF阅读器 | sudo pacman -S zathura zathura-pdf-poppler |     |
| 解压缩 | sudo pacman -S file-roller p7zip unrar |     |

## 字体

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| Sarasa | sudo pacman -S ttf-sarasa-gothic | |
| 英文字体 | sudo pacman -S ttf-fira-code ttf-jetbrains-mono | |
| Nerd | sudo pacman -S ttf-firacode-nerd ttf-jetbrains-mono-nerd | |
| 图标 | sudo pacman -S awesome-terminal-fonts otf-font-awesome | |
| material icons | yay -S ttf-material-design-icons-webfont | |

刷新字库

`fc-cache -f -v`

## Misc

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| AUR 助手 | sudo pacman -S yay |  |
| 启动器 | yay -S rofi-lbonn-wayland |     |
| 编辑器 | sudo pacman -S neovide | sudo pacman -s python-pynvim |
| 编辑器 | yay -S visual-studio-code-bin neovide | |
| 磁盘管理 | sudo pacman -S gparted |     |
| 启动盘制作 | sudo pacman -S ventoy |     |
| 防火墙 | sudo pacman -S gufw | sudo ufw enable |
| 笔记  | sudo pacman -S joplin-desktop |     |
| 字体管理器 | sudo pacman -S font-manager |     |
| 办公软件 | sudo pacman -S libreoffice libreoffice-fresh-zh-cn | 直接回车或选择 [1] |
| 科学上网 | sudo pacman -S v2raya |     |
| 浏览器 | yay - S google-chrome |     |
| 剪贴板 | sudo pacman -S cliphist | |
| 截图 | sudo pacman -S grim slurp | |

## CLI

| 软件 | 安装命令 | 备注 |
| --- | ------- | --- |
| 网络工具 | sudo pacman -S net-tools |     |
| 替代curl | sudo pacman -S httpie |     |
| 显示系统信息 | sudo pacman -S neofetch btop |     |
| 娱乐工具 | sudo pacman -S fortune-mod cowsay sl cmatrix |     |
| 替换 find | sudo pacman -S fd |     |
| 替换 grep | sudo pacman -S ripgrep |     |
| 替换 cat | sudo pacman -S bat |     |
| 简化版 man 手册 | sudo pacman -S tldr | `第一次使用tldr之前，需要更新一下缓存 tldr --update` |
| 模糊查找 | sudo pacman -S fzf |     |
| shellcheck | sudo pacman -S shellcheck | |
| 其他  | sudo pacman -S jq zenity tree lolcat |     |

## 多媒体

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

## 其他

1.java

`sudo pacman -S jre17-openjdk`

2.npm

`sudo pacman -S npm`

npm源配置

```bash
npm config set registry https://registry.npmmirror.com
```

3.red

`sudo pacman -S lib32-gtk3`
