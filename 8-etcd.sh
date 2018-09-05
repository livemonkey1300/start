#!/bin/bash

yum -y install etcd

systemctl enable etcd
systemctl start etcd