#!/bin/bash

#yum -y install chrony

DATE=$(date +%F-%T)
NTP_CONFIG='/etc/chrony.conf'
NTP_SERVER='ca.pool.ntp.org'
OLD_NTP='centos.pool.ntp.org'
#server 0.centos.pool.ntp.org iburst
#server 1.centos.pool.ntp.org iburst
#server 2.centos.pool.ntp.org iburst
#server 3.centos.pool.ntp.org iburst

#cp -p "$NTP_CONFIG" "~/chrony.conf.$DATE"
sed 's/$OLD_NTP/$NTP_SERVER/gc' $NTP_CONFIG