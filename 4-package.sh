#!/bin/bash

sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config 
yum -y install centos-release-openstack-queens
yum upgrade
yum install python-openstackclient
