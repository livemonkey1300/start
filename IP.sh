#!/bin/bash


############################
# Generate a bunch of hash #
############################

PasswordDate=$(date +%F-%T)
PasswordFile="./Data/PasswordFile-$PasswordDate"
touch -p "$PasswordFile"

while read line 
do 
var=$(openssl rand -base64 32 | sed 's/[^a-zA-Z0-9]//g' )
echo "$line , $var"
echo "export $line=$var" >> "$PasswordFile"
done < PasswordFile

#sed 's/[A-Za-z][A-Za-z]*$/replace/' file.txt
#sed 's/[A-Za-z][A-Za-z]*$/replace/' file.txt
#ls -1 /etc/sysconfig/network-scripts/ifcfg-*