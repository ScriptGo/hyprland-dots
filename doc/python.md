## pip

`sudo pacman -S python-pip`

修改pip源

`pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple`

pip 常用命令

| 命令 | 描述 |
| --- | ---- |
| pip --help | 查看 pip 相关命令和参数 |
| pip --version | 显示 pip 版本和安装路径 |
| pip install pkgname | 安装软件包 |
| pip unstall pkgname | 卸载软件包 |
| pip list | 列出已安装的软件包 |
| pip list --outdated | 列出可以升级的软件包 |
| pip install -U pkgname | 升级软件包 |
| pip install --upgrade pkgname | 升级软件包 |

## jupyterlab

```
sudo pacman -S tk
sudo pacman -S jupyterlab
sudo pacman -S jupyterlab-widgets
sudo pacman -S python-qtconsole
```

生成配置文件

`jupyter lab --generate-config`

常用的插件

```
python -m pip install jupyterlab_gruvbox_dark
python -m pip install jupyterlab-language-pack-zh-cn
```

## 模块

### 内置模块

| 模块 | 描述 | 导入方式 |
|------|------|------|
| os | 提供了常见的操作系统相关功能，很多功能是针对文件系统 | import os |
| pathlib | | import |
| sys | 这个模块可供访问由解释器使用或维护的变量和与解释器进行交互的函数 | import sys |
| shutil |相对于 os 而言，shutil 提供了一些比较高级的文件和目录操作（目录递归复制、目录递归删除、目录压缩打包...）| import |
| base64 | 提供 Base16、Base32、Base64 格式的编码和解码 | import |
| glob | 用于查找文件，【支持通配符】（* 和 ?）| import |
| subprocess | 用于进程管理，可以启动子进程，通过标准输入输出跟子进程交互 | import |
| platform | 这个模块提供了很多用于获取操作系统的信息的功能 | import |
| psutil | 一个跨平台的进程管理和系统工具库，可以处理”CPU、内存、磁盘、网络、用户“等信息 | import |
| re | 提供基于正则的匹配和替换| import re |

| 模块 | 描述 | 导入方式 |
|------|------|------|
| collections | | import |
| functools | | import |
| dataclasses | | import |
| itertools | | import |
| 模块 | 描述 | 导入方式 |

|------|------|------|
| turtle | 绘图 | import |
| Pillow | 对图像进行各种常见的处理（旋转、缩放、剪切 ...）| from PIL import * (*代表要导入使用的功能)|


| 模块 | 描述 | 导入方式 |
|------|------|------|
| math | 封装了常用的数学函数 | import math |
| random | 用来进行随机数生成 | import random |

| 模块 | 描述 | 导入方式 |
|------|------|------|
| csv | csv 格式文件的读写，可以手动指定行列分隔符 | import csv |
| json | json 格式的编码和解码 | import json |
| yaml | 一种类似于 json 的结构化数据格式。它在确保可读性的基础上，提供了超越 json 的灵活性和扩展性 | import yaml |
| tomllib | | import tomllib |


## 第三方模块

### 语法

| 模块 | 描述 | 安装 | 导入方式 |
|------|------|------|------|
| flake8 | 语法检查 | python -m pip install flake8 ||
| isort | 模块整理 | python -m pip install isort ||
| black | 代码格式化 | python -m pip install black ||
| pytest | | python -m pip install pytest ||

### 爬虫

| 模块 | 描述 | 安装 | 导入方式 |
|------|------|------|------|
| httpx | 网络请求 | python -m pip install "httpx[http2]" | import httpx |
| beautifulsoup | 网页抓取 | python -m pip install beautifulsoup4 | from bs4 import BeautifulSoup |
| selenium | 非常优秀的框架，用于爬虫和 Web 自动化测试 | python -m pip install selenium | 
| Scrapy | 为了爬取网站数据，提取结构性数据而编写的应用框架 | python -m pip install Scrapy |

### 数据分析

| 模块 | 描述 | 安装 | 导入方式 |
|------|------|------|------|
| pandas | 数据分析 | python -m pip install pandas | import pandas as pd |
| numpy  | 数据分析 | python -m pip install numpy | import numpy as np |
| scipy  | 数据分析 | python -m pip install scipy ||
| matplotlib | 数据可视化 | python -m pip install matplotlib ||
| pyecharts | 数据可视化 | python -m pip install pyecharts pyecharts_snapshot ||

### 数据库连接

| 模块 | 描述 | 安装 | 导入方式 |
|------|------|------|------|
| pymongo | 连接mongodb | python -m pip install pymongo |
| pymysql | 连接mysql | python -m pip install PyMySQL |

### 其他

| 模块 | 描述 | 安装 | 导入方式 |
|------|------|------|------|
| Openpyxl | 处理Excel文件 | python -m pip install openpyxl | |
| gspread | 操作Google Sheets | python -m pip install gspread | import gspread |
| Faker | 填充假数据 | python -m pip install Faker |
| click | 命令行参数处理 | python -m pip install click |
| rich | 在终端中提供富文本和精美格式 | python -m pip install rich |
| textual | 文本用户界面设计 | python -m pip install textual |
| PySimpleGUI | GUI设计 | python -m pip install pysimplegui | import PySimpleGUI as sg |


## Anaconda

### 安装

`yay -S anaconda`

### 配置

1. 配置环境变量

在 `~/.zshrc` 中添加下面这条语句：

`export PATH=/opt/anaconda/bin:$PATH`

保存退出后，使环境变量生效：

`source ~/.zshrc`

2. 激活环境

`source /opt/anaconda/bin/activate root`

3. 配置镜像源

在家目录下创建 `.condarc` 文件，添加以下内容:

```
channels:
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
```

运行 sudo conda clean -i 清除索引缓存，保证用的是镜像站提供的索引。


### 命令

| 命令         |           说明           |       备注       |
| :----------- | :----------------------: | :--------------: |
| conda -h     |  查看 conda 的帮助信息   |   conda --help   |
| conda CMD -h | 查看具体 CMD 的帮助信息  | conda CMD --help |
| conda -V     |     查看 conda 版本      | conda --version  |
| python -V    | 查看 python 解释器的版本 | python --version |


环境管理

| 命令                                        |                           说明                           |            备注 |
| ------------------------------------------- | :------------------------------------------------------: | --------------: |
| conda info           | 查看 conda 环境详细信息  |      |
| conda info -e        |   查看系统中的所有环境   |      |
| conda info --envs    |   查看系统中的所有环境   |      |
| conda env list       |   查看系统中的所有环境   |      |
| conda create -n env-name                    |              创建名为 `env-name` 的虚拟环境              |                 |
| conda create --name env-name                |              创建名为 `env-name` 的虚拟环境              |                 |
| conda create -n env-name python=3.11        | 创建名为 `env-name` 的虚拟环境并同时安装指定版本的python |                 |
| conda create --clone env-name -n new-env    |                       克隆虚拟环境                       |                 |
| conda rename -n env-name new-env            |                      重命名虚拟环境                      |                 |
| conda remove -n env-name --all              |                       删除虚拟环境                       |                 |
| conda activate / deactivate env-name        |                   激活 / 关闭虚拟环境                    |     for windows |
| source conda activate / deactivate env-name |                   激活 / 关闭虚拟环境                    | for Linux & Mac |

包管理

| 命令                                  |                    说明                     |                      备注 |
| :------------------------------------ | :-----------------------------------------: | ------------------------: |
| conda list                            |     查看当前虚拟环境中安装的所有软件包      |                           |
| conda list -n env-name                |     查看指定虚拟环境中安装的所有软件包      |                           |
| conda install pkg-name                |         在当前虚拟环境中安装软件包          |    可以同时安装多个软件包 |
| conda install pkg-name=version-number |    在当前虚拟环境中安装指定版本的软件包     |                      同上 |
| conda install -n env-name pkg-name    |        在指定的虚拟环境中安装软件包         |                      同上 |
| conda remove pkg-name                 |         卸载当前虚拟环境中的软件包          |    可以同时卸载多个软件包 |
| conda remove -n env-name pkg-name     |         卸载指定虚拟环境中的软件包          |                      同上 |
| conda update pkg-name                 |                                             |                           |
| conda update -n env pkg-name          |                                             |                           |
| conda update --all                    |       更新当前虚拟环境中的所有软件包        |                           |
| conda update --all -n env-name        |       更新指定虚拟环境中的所有软件包        |                           |
| codna search pkg-name                 |                                             |                           |
| conda search --full-name pkg-name     |                                             |                           |
| conda clean -i                        |                删除索引缓存                 | conda clean --index-cache |
| conda clean -p                        |             删除没有用的安装包              |    conda clean --packages |
| conda clean -t                        |                  删除tar包                  |    conda clean --tarballs |
| conda clean -a                        | 删除索引缓存、锁定文件、未使用过的包和tar包 |         conda clean --all |

镜像源管理

| 命令                                 |           说明           | 备注 |
| :----------------------------------- | :----------------------: | ---: |
| conda config                         |  创建配置文件 .condarc   |      |
| conda config --show                  |     查看 conda 配置      |      |
| conda config --show channels         |      查看当前镜像源      |      |
| conda config --show-sources          | 查看配置文件路径及镜像源 |      |
| conda config --add channels 'url'    |        添加镜像源        |      |
| conda config --remove channels 'url' |        移除镜像源        |      |
