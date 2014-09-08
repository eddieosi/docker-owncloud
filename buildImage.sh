#/bin/sh

docker pull paintedfox/mariadb
docker pull sylvainlasnier/memcached
docker build --tag=eddieosi/owncloud .
