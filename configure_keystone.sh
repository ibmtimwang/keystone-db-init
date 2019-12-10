#!/bin/bash

#MYSQL_HOST=keystone-mariadb
MYSQL_PORT=3306
MYSQL_PASSWORD=keystone 
MYSQL_HOST=10.131.0.139

if [ -z "$MYSQL_PASSWORD" ]
then MYSQL_PASSWORD=$( cat /etc/keystone/dbpass.txt )
fi

cat /var/`whoami`


echo -n Database 
mysql -h $MYSQL_HOST  -P$MYSQL_PORT --user=keystone --password=$MYSQL_PASSWORD < keystone-configure.sql
echo " [COMPLETE]"
 
echo -n "configuration "
openstack-config  --set  /etc/keystone/keystone.conf database connection mysql+pymysql://keystone:$MYSQL_PASSWORD@$MYSQL_HOST/keystone
DATABASE_CONN=`openstack-config  --get  /etc/keystone/keystone.conf database connection `
echo $DATABASE_CONN
 
echo " [COMPLETE]"
 
echo -n "db-sync "
keystone-manage db_sync
echo " [COMPLETE]"
 
echo -n "bootstrap "
keystone-manage bootstrap --bootstrap-password=FreeIPA4All
echo " [COMPLETE]"
