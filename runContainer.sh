#!/bin/bash


#first parameter will be the port number for magento


if [ $# -eq 0 ]
  then
    echo "No Parameter found"
    echo "Usage: runContainer.sh 8080"

else

    DATABASE_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    DATABASE_UUID="database_$DATABASE_UUID"

    MEMCACHED_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    MEMCACHED_UUID="memcached_$MEMCACHED_UUID"


    docker run -td --name $DATABASE_UUID -e USER=user -e PASS=password  paintedfox/mariadb
    docker run --name $MEMCACHED_UUID -d -p 11211 sylvainlasnier/memcached
#   docker run -p $1:80 --link $DATABASE_UUID:db --link $MEMCACHED_UUID:cache -v /opt/owncloud:/app/data -td eddieosi/owncloud
    docker run -p $1:80 --link $DATABASE_UUID:db --link $MEMCACHED_UUID:cache -td eddieosi/owncloud

fi
