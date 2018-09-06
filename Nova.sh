#!/bin/bash

 sed "s/NOVA_DBPASS/$NOVA_DBPASS/g" SQL/nova.txt | mysql -uroot -p"$ROOT_PASS"

openstack user create --domain default --password "$NOVA_PASS" nova

openstack role add --project service --user nova admin

openstack service create --name nova  --description "OpenStack Compute" compute
openstack endpoint create --region RegionOne compute public http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://controller:8774/v2.1

openstack user create --domain default --password "$PLACEMENT_PASS" placement
openstack role add --project service --user placement admin
openstack service create --name placement --description "Placement API" placement


openstack endpoint create --region RegionOne placement public http://controller:8778
openstack endpoint create --region RegionOne placement internal http://controller:8778
openstack endpoint create --region RegionOne placement admin http://controller:8778

yum  -y install openstack-nova-api openstack-nova-conductor openstack-nova-console openstack-nova-novncproxy openstack-nova-scheduler openstack-nova-placement-api

#sed -i "/^\[database\]$/a connection = mysql+pymysql://glance:$GLANCE_DBPASS@controller/glance"  /etc/glance/glance-api.conf


CONFIGDIR='./SysData/Nova/'
while read line 
do
echo "$line"
CONFIGFILE=$CONFIGDIR$line
while read config 
do
echo $config 
sed -i "/^\[$line\]$/a $config"  /etc/nova/nova.conf 
done < "$CONFIGFILE"

done < <(ls -1 $CONFIGDIR)

sed -i "s/NOVA_DBPASS/$NOVA_DBPASS/g" /etc/nova/nova.conf 
sed -i "s/NOVA_PASS/$NOVA_PASS/g" /etc/nova/nova.conf 
sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" /etc/nova/nova.conf 
sed -i "s/PLACEMENT_PASS/$PLACEMENT_PASS/g" /etc/nova/nova.conf 

while read line 
do
	grep "^\[$line\]" -A10 /etc/glance/glance-api.conf
done < <(ls -1 $CONFIGDIR)

# systemctl restart httpd
# su -s /bin/sh -c "nova-manage api_db sync" nova
# su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
# su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
# su -s /bin/sh -c "nova-manage db sync" nova
# nova-manage cell_v2 list_cells

# systemctl enable openstack-nova-api.service openstack-nova-consoleauth.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service
# systemctl start openstack-nova-api.service openstack-nova-consoleauth.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service