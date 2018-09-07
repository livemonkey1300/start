#!/bin/bash


scp ~/keystonerc root@compute1:~/keystonerc
scp /etc/hosts root@compute1:/etc/hosts

ssh root@compute1 <<EOF
echo "source ~/keystonerc " >> ~/.bash_profile
sed -i "s/10.100.1.30/10.100.1.50/g" ~/keystonerc
source ~/keystonerc
yum -y install git
git clone https://github.com/livemonkey1300/start.git
cd start
git reset --hard
git pull
chmod 777 *.sh
./3-2ntp-slave.sh
./4-package.sh
./Nova-host.sh
EOF

