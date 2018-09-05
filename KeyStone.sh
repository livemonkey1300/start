#!/bin/bash

mysql -u root -p"$ROOT_PASS" < sed "s/KEYSTONE_DBPASS/$KEYSTONE_DBPASS/g" SQL/keystone.tx