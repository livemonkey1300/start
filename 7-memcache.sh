#!/bin/bash

yum -y install memcached python-memcached
arg='"-l 127.0.0.1,::1,controller"'
sed -i "s/#OPTIONS=/OPTIONS=/g" /etc/sysconfig/memcached
sed -i "s/OPTIONS=/OPTIONS=$arg/g" /etc/sysconfig/memcached

systemctl enable memcached.service
systemctl start memcached.service