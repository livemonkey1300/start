#!/bin/bash

sed "s/GLANCE_DBPASS/$GLANCE_DBPASS/g" SQL/glance.txt | mysql -uroot -p"$ROOT_PASS"

openstack user create --domain default --password "$GLANCE_PASS" glance

openstack role add --project service --user glance admin

openstack service create --name glance --description "OpenStack Image" image
openstack endpoint create --region RegionOne image public http://controller:9292
openstack endpoint create --region RegionOne image internal http://controller:9292
openstack endpoint create --region RegionOne image admin http://controller:9292

yum -y install openstack-glance

sed -i '/\[database\]/a connection = mysql+pymysql://glance:$GLANCE_DBPASS@controller/glance'  /etc/glance/glance-api.conf

