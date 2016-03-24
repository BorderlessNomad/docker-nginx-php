FROM       ahirmayur/ubuntu
MAINTAINER Mayur Ahir "https://github.com/ahirmayur"

ENV LANG C.UTF-8
RUN echo "LC_ALL=en_GB.UTF-8" >> /etc/default/locale
RUN locale-gen en_GB.UTF-8

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN add-apt-repository -y ppa:nginx/stable
RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update

RUN apt-get install -y nginx php7.0 php7.0-fpm php7.0-mysql php7.0-curl php7.0-json

# Shell script must run the daemon without letting it daemonize/fork it
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

# Set listen port
RUN sed -i 's/listen = \/run\/php\/php7.0-fpm.sock/;listen = \/run\/php\/php7.0-fpm.sock\nlisten = 127.0.0.1:9000/g' /etc/php/7.0/fpm/pool.d/www.conf

# Security
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini

RUN rm -rf /etc/nginx/sites-enabled/default
ADD sources/site /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site

# Install composer
RUN curl -sS https://getcomposer.org/installer | php 
RUN mv composer.phar /usr/bin/composer

ADD sources/nginx-start /usr/local/bin/
RUN chmod +x /usr/local/bin/nginx-start

ADD sources/info.php /var/www/

EXPOSE 80

CMD nginx-start