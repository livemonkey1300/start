#!/bin/bash

yum -y install chrony

DATE=$(date +%F-%T)
NTP_CONFIG='/etc/chrony.conf'
NTP_SERVER='controller'
OLD_NTP='0.centos.pool.ntp.org'
#server 0.centos.pool.ntp.org iburst
#server 1.centos.pool.ntp.org iburst
#server 2.centos.pool.ntp.org iburst
#server 3.centos.pool.ntp.org iburst

cp -p "$NTP_CONFIG" "~/chrony.conf.$DATE"
sed -i "s/$OLD_NTP/$NTP_SERVER/g" "$NTP_CONFIG"
sed -i "s/server.*centos.*$/#/g" "$NTP_CONFIG"

systemctl enable chronyd.service
systemctl start chronyd.service

chronyc sources