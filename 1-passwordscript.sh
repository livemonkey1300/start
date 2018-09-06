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

read -p 'What is your ip' myip
echo "" >> "$PasswordFile"
echo "export MYIP=$myip" >> "$PasswordFile"


echo "Do you want to save the PasswordFile (Y/y) "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    cp "$PasswordFile" ~/keystonerc
    echo "source ~/keystonerc " >> ~/.bash_profile
else
    echo OK
fi

#sed 's/[A-Za-z][A-Za-z]*$/replace/' file.txt
#sed 's/[A-Za-z][A-Za-z]*$/replace/' file.txt
#ls -1 /etc/sysconfig/network-scripts/ifcfg-*