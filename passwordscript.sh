#!/bin/bash


############################
# Generate a bunch of hash #
############################

DataDir='./Data'
PasswordDate=$(date +%F-%T)
PasswordFile="$DataDir/PasswordFile-$PasswordDate"
mkdir -p "$DataDir"
touch "$PasswordFile"

while read line 
do 
var=$(openssl rand -base64 32 | sed 's/[^a-zA-Z0-9]//g' )
echo "export $line=$var" >> "$PasswordFile"
done < PasswordFile



#sed 's/[A-Za-z][A-Za-z]*$/replace/' file.txt
#sed 's/[A-Za-z][A-Za-z]*$/replace/' file.txt
#ls -1 /etc/sysconfig/network-scripts/ifcfg-*