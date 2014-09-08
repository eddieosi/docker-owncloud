#! /bin/bash

if [[ -e /firstrun ]]; then

echo "not first run so skipping initialization"

else 

echo "Creating the owncloud database..."

echo "create database owncloud" | mysql -u "$DB_ENV_USER" --password="$DB_ENV_PASS" -h db -P "$DB_PORT_3306_TCP_PORT"

while [ $? -ne 0 ]; do
	sleep 5
        echo "create database owncloud" | mysql -u "$DB_ENV_USER" --password="$DB_ENV_PASS" -h db -P "$DB_PORT_3306_TCP_PORT"
        echo "show tables" | mysql -u "$DB_ENV_USER" --password="$DB_ENV_PASS" -h db -P "$DB_PORT_3306_TCP_PORT" owncloud
done

touch /firstrun

fi

/sbin/my_init
