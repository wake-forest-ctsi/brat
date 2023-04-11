FROM httpd:2.4

# Install Python2
RUN apt-get update
RUN apt-get install -y python2
RUN ln -s  /usr/bin/python2.7 /usr/bin/python

# Copy file and apache config
COPY . /usr/local/apache2/htdocs
COPY ./httpd/httpd.conf /usr/local/apache2/conf
RUN mv /usr/local/apache2/htdocs/config_docker.py /usr/local/apache2/htdocs/config.py

# BRAT user setup
ENV ADMIN_CONTACT_EMAIL=example@admin.com
ENV USER_NAME=user
ENV USER_PASS=pass

# Manage server user file permissions
RUN chgrp -R www-data /usr/local/apache2/htdocs
RUN chmod -R 575 /usr/local/apache2/htdocs
