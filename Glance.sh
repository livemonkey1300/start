#!/bin/bash

 sed "s/GLANCE_DBPASS/$GLANCE_DBPASS/g" SQL/glance.txt | mysql -uroot -p"$ROOT_PASS"

openstack user create --domain default --password "$GLANCE_PASS" glance

openstack role add --project service --user glance admin

openstack service create --name glance --description "OpenStack Image" image
openstack endpoint create --region RegionOne image public http://controller:9292
openstack endpoint create --region RegionOne image internal http://controller:9292
openstack endpoint create --region RegionOne image admin http://controller:9292

yum -y install openstack-glance

#sed -i "/^\[database\]$/a connection = mysql+pymysql://glance:$GLANCE_DBPASS@controller/glance"  /etc/glance/glance-api.conf


CONFIGDIR='./SysData/Glance/'
while read line 
do
echo "$line"
CONFIGFILE=$CONFIGDIR$line
while read config 
do
echo $config 
sed -i "/^\[$line\]$/a $config"  /etc/glance/glance-api.conf
done < "$CONFIGFILE"

done < <(ls -1 $CONFIGDIR)

sed -i "s/GLANCE_DBPASS/$GLANCE_DBPASS/g" /etc/glance/glance-api.conf
sed -i "s/GLANCE_PASS/$GLANCE_PASS/g" /etc/glance/glance-api.conf


while read line 
do
	grep "^\[$line\]" -A10 /etc/glance/glance-api.conf
done < <(ls -1 $CONFIGDIR)

su -s /bin/sh -c "glance-manage db_sync" glance

systemctl enable openstack-glance-api.service openstack-glance-registry.service
systemctl start openstack-glance-api.service openstack-glance-registry.service