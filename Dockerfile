FROM ubuntu:focal

RUN apt-get update -y

#Installing apache in non-interactive mode
ARG DEBIAN_FRONTEND=noninteractive

#Installing apache web server
RUN apt-get install apache2 -y

#Installing PHP v 8.2
RUN apt-get -y install software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get -y install php8.2

#Installing vim 
RUN apt install vim -y

#Installing required PHP extensions
RUN apt-get install -y php8.2-bcmath php8.2-fpm php8.2-xml php8.2-mysql php8.2-zip php8.2-intl php8.2-ldap php8.2-gd php8.2-cli php8.2-bz2 php8.2-curl php8.2-mbstring php8.2-pgsql php8.2-opcache php8.2-soap php8.2-cgi

#Installing MySQL
RUN apt-get update -qq && apt-get install -y mysql-server

RUN sed -i 's#/var/www/html#/var/www/html/example-app/public#g' /etc/apache2/sites-available/000-default.conf

ADD laravel11.sql /

RUN mkdir -p /var/www/html/example-app

ADD ./example-app /var/www/html/example-app/

ADD apache2.conf /etc/apache2/

RUN chmod 777 -R /var/www/html/example-app/storage

EXPOSE 80 3306

ADD start.sh /

RUN chmod +x /start.sh

CMD ["/usr/bin/bash", "/start.sh"]