#!/bin/bash


############################
# Generate a bunch of hash #
############################

while read line 
do 
var=$(openssl rand -base64 32 | sed 's/[^a-zA-Z0-9]//g' )
echo "$line , $var"
done < PasswordFile

sed 's/[A-Za-z][A-Za-z]*$/replace/' file.txt
ls -1 /etc/sysconfig/network-scripts/ifcfg-*