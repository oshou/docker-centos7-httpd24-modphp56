# Pull base image
FROM centos:7

# Locale & Timezone
RUN sed -i -e "s/LANG=\"en_US.UTF-8\"/LANG=\"ja_JP.UTF-8\"/g" /etc/locale.conf && \
    cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# System update
RUN yum -y update

# Install repository
RUN yum install -y epel-release && \
    rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel7.noarch.rpm && \
<<<<<<< HEAD
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \

RUN yum install -y \
        # Tools
        less \
        libcurl \
        net-tools && \
    yum install -y --enablerepo=epel,remi \
        # httpd
        httpd \
        mod_ssl && \
    yum install -y --enablerepo=remi-php56 \
=======
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
COPY conf/unit.repo /etc/yum.repos.d/unit.repo

# Install Curl
RUN yum install -y \
        libcurl \
        net-tools

# Install Nginx Unit
RUN yum install unit -y --enablerepo=unit

# Install PHP7
RUN yum install -y --enablerepo=remi-php54 \
>>>>>>> temp1
        php \
        php-devel \
        php-embedded \
        php-mcrypt \
        php-mbstring \
        php-gd \
        php-mysql \
        php-pdo \
        php-xml \
        php-pecl-apcu \
        php-pecl-zendopcache
    # cache cleaning
    yum clean all
        


<<<<<<< HEAD
# httpd setting
COPY ./conf/httpd.conf /etc/httpd/conf/httpd.conf
COPY ./conf/00-mpm.conf /etc/httpd/conf.modules.d/00-mpm.conf
RUN chmod -R 755 /var/www && chown -R www-data:www-data /var/www
=======
# Httpd setting(mod_php)
# COPY ./conf/httpd.conf /etc/httpd/conf/httpd.conf
# COPY ./conf/00-mpm.conf /etc/httpd/conf.modules.d/00-mpm.conf
# RUN chmod -R 755 /var/www && chown -R www-data:www-data /var/www
>>>>>>> temp1

# PHP setting
RUN mkdir -p /var/www/php && chmod -R 755 /var/www/php
COPY ./conf/config.json /etc/unit/config.json
COPY ./conf/start.sh /etc/unit/start.sh
COPY ./conf/php.ini /etc/php.ini
COPY ./conf/index.php /var/www/php/index.php
RUN chmod -R 755 /var/www/php && \
        chmod 755 /etc/unit/config.json && \
        chmod 755 /etc/unit/start.sh && \
        chmod 755 /etc/php.ini && \
        chmod 755 /etc/unit/start.sh


# Listen port
EXPOSE 8300

# Startup
CMD ["/etc/unit/start.sh"]
