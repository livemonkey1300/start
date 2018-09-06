#!/bin/bash

# sed "s/GLANCE_DBPASS/$GLANCE_DBPASS/g" SQL/glance.txt | mysql -uroot -p"$ROOT_PASS"

# openstack user create --domain default --password "$GLANCE_PASS" glance

# openstack role add --project service --user glance admin

# openstack service create --name glance --description "OpenStack Image" image
# openstack endpoint create --region RegionOne image public http://controller:9292
# openstack endpoint create --region RegionOne image internal http://controller:9292
#openstack endpoint create --region RegionOne image admin http://controller:9292

#yum -y install openstack-glance

#sed -i "/^\[database\]$/a connection = mysql+pymysql://glance:$GLANCE_DBPASS@controller/glance"  /etc/glance/glance-api.conf


CONFIGDIR = './SysData/Glance/'
while read line 
do 
#sed -i "/^\[paste_deploy\]$/a $line"  /etc/glance/glance-api.conf
echo "$line"
CONFIGFILE = "$CONFIGDIR$line"
while read config 
do 
sed -i "/^\[$line\]$/a $config"  /etc/glance/glance-api.conf
done < "$CONFIGFILE"

done < <(ls -1 "$CONFIGDIR")

# keystone_authtoken='./SysData/Glance/keystone_authtoken'
# paste_deploy='./SysData/Glance/paste_deploy'
# while read line 
# do 
# sed -i "/^\[keystone_authtoken\]$/a $line"  /etc/glance/glance-api.conf
# done < "$keystone_authtoken"

# sed -i "/^\[keystone_authtoken\]$/a password = $GLANCE_PASS"  /etc/glance/glance-api.conf



# while read line 
# do 
# sed -i "/^\[paste_deploy\]$/a $line"  /etc/glance/glance-api.conf
# done < "$paste_deploy"

