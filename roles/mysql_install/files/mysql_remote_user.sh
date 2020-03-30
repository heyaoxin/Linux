#!/bin/bash
mysql <<EOF
grant all on *.* to "xiaoming"@"%" identified by "123456";
flush privileges;
EOF
#修改编码方式
sed -i "/^\[mysqld\]$/a\character-set-server=utf8" /etc/my.cnf.d/server.cnf 
sed -i "/^\[client\]$/a\default-character-set=utf8" /etc/my.cnf.d/client.cnf

