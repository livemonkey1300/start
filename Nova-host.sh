#!/bin/bash

yum install openstack-nova-compute

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
sed -i "s/MYIP/$MYIP/g" /etc/nova/nova.conf 
sed -i "s/^server_listen.*$/server_listen = 0.0.0.0/g" /etc/nova/nova.conf 
sed -i "/^\[$vnc\]$/a novncproxy_base_url = http://controller:6080/vnc_auto.html" /etc/nova/nova.conf 

while read line 
do
	grep "^\[$line\]" -A10 /etc/nova/nova.conf 
done < <(ls -1 $CONFIGDIR)

systemctl enable libvirtd.service openstack-nova-compute.service
systemctl start libvirtd.service openstack-nova-compute.service
# systemctl restart httpd
# su -s /bin/sh -c "nova-manage api_db sync" nova
# su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
# su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
# su -s /bin/sh -c "nova-manage db sync" nova
# nova-manage cell_v2 list_cells

# systemctl enable openstack-nova-api.service openstack-nova-consoleauth.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service
# systemctl start openstack-nova-api.service openstack-nova-consoleauth.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service