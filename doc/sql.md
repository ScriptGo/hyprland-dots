## MongoDB

1. 安装

`yay -S mongodb-bin mongodb-tools-bin mongodb-compass`

2. 安装完成后，执行下面的命令

`libtool --finish /usr/lib`

3. 配置

```shell
sudo mkdir -p /data/db       # 创建目录(数据库存放处)
sudo chown -R $USER /data/db # 修改目录权限
```

4. 启动服务

```shell
sudo systemctl start mongodb.service  # 启动服务
sudo systemctl enable mongodb.service # 开机自启
```


## MariaDB

1. 安装MariaDb

```shell
sudo pacman -S mariadb mariadb-clients
```

2. 初始化MariaDb数据库

```shell
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```

3. 启动MariaDb

```sehll
sudo systemctl start mariadb     # 启动MariaDb服务
sudo systemctl enable mariadb    # 开机自启动
```

4. 为root用户添加密码

```shell
sudo mysqladmin -u root password ""
```

5. 编码配置

修改：/etc/my.cnf

```shell
[client]
default-character-set = utf8mb4

[mysqld]
collation_server = utf8mb4_unicode_ci
character_set_client = utf8mb4
character_set_server = utf8mb4
skip-character-set-client-handshake

[mysql]
default-character-set = utf8mb4
```

6. 登录数据库

`mysql -uroot -p`
