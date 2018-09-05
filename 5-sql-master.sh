#!/bin/bash

yum -y install mariadb mariadb-server python2-PyMySQL

sed -i "s/1.1.1.1/$MYIP/g" SysData/openstack.cnf
cp SysData/openstack.cnf /etc/my.cnf.d/

systemctl enable mariadb.service
systemctl start mariadb.service


mysql_secure_installation <<EOF

y
$ROOT_PASS
$ROOT_PASS
y
y
y
y
EOF