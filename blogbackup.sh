#!/bin/bash
cd /home/centos/backup
mkdir -p /home/centos/backup/workdir
time_stamp=$(date +%Y_%m_%d_%H_%M_%S)
mkdir -p "/home/centos/backup/workdir/${time_stamp}"
sudo cp /var/www/html/blogapp.war "/home/centos/backup/workdir/${time_stamp}"
if [ -d "/tmp/Blog" ];
then
sudo cp -R /tmp/Blog"/home/centos/backup/workdir/${time_stamp}/"
fi
cd "/home/centos/backup/workdir/${time_stamp}/"
tar cvfz "$1_${time_stamp}.tgz" *
s3cmd put "$1_${time_stamp}.tgz"  s3://millionbackup
sudo rm -rf /home/centos/backup/workdir/