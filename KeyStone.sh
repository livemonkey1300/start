#!/bin/bash

sed "s/KEYSTONE_DBPASS/$KEYSTONE_DBPASS/g" SQL/keystone.txt | mysql -uroot -p"$ROOT_PASS"

yum install openstack-keystone httpd mod_wsgi


sed -i "s/#connection =.*$/connection = mysql+pymysql:\/\/keystone:$KEYSTONE_DBPASS@controller\/keystone/g" /etc/keystone/keystone.conf
sed -i "s/#provider =.*$/provider = fernet/g" /etc/keystone/keystone.conf
su -s /bin/sh -c "keystone-manage db_sync" keystone

keystone-manage bootstrap --bootstrap-password $ADMIN_PASS \
  --bootstrap-admin-url http://controller:5000/v3/ \
  --bootstrap-internal-url http://controller:5000/v3/ \
  --bootstrap-public-url http://controller:5000/v3/ \
  --bootstrap-region-id RegionOne

  
sed -i "s/#ServerName.*$/ServerName controller/g" /etc/httpd/conf/httpd.conf
ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/

systemctl enable httpd.service
systemctl start httpd.service

echo "export OS_USERNAME=admin" >> ~/keystonerc
echo "export OS_PASSWORD=$ADMIN_PASS" >> ~/keystonerc
echo "export OS_PROJECT_NAME=admin" >> ~/keystonerc
echo "export OS_USER_DOMAIN_NAME=Default" >> ~/keystonerc
echo "export OS_PROJECT_DOMAIN_NAME=Default" >> ~/keystonerc
echo "export OS_AUTH_URL=http://controller:35357/v3" >> ~/keystonerc
echo "export OS_IDENTITY_API_VERSION=3" >> ~/keystonerc