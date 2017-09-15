#!/bin/bash
cd /home/centos/backup
mkdir -p /home/centos/backup/workdir
time_stamp=$(date +%Y_%m_%d_%H_%M_%S)
mkdir -p "/home/centos/backup/workdir/${time_stamp}"

sudo  mysqldump --routines -u root -pTest123 Demo> "/home/centos/backup/workdir/${time_stamp}/Demo.sql"
sudo  mysqldump --routines -u root -pTest123 $1 > "/home/centos/backup/workdir/${time_stamp}/$1.sql"
cd "/home/centos/backup/workdir/${time_stamp}/"
tar cvfz "$1_${time_stamp}.tgz" *
s3cmd put "$1_${time_stamp}.tgz"  s3://millionbackup
sudo rm -rf /home/centos/backup/workdir/