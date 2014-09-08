FROM bradfeehan/magento
# Based on bradfeehan/magento

MAINTAINER eddieosi <docker@humanbyte.de>

# Regenerate SSH host keys. This image does not contain any, so you
# have to do that yourself. You may also comment out this instruction;
# the init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh


# ...put your own build instructions here...


# ...

RUN apt-get update
RUN apt-get install wget -y
RUN apt-get install mysql-client mysql-common -y

# Clean up APT when done to save space
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get owncloud
RUN cd /tmp && wget https://download.owncloud.com/download/community/setup-owncloud.php

# remove default index.php from /app folder
RUN rm /app/index.php

# copy magento contents to /app folder
RUN cp -R /tmp/* /app

# add starter PHP file
ADD config/index.php /app/index.php

# add autoconfig for pre configuring the owncloud installer
ADD config/autoconfig.php /app/config/autoconfig.php
RUN chown -R www-data:www-data /app

# add start.sh
ADD config/start.sh /root/start.sh

RUN chmod +rwx /root/start.sh

EXPOSE 80

CMD ["/bin/sh", "/root/start.sh"]
