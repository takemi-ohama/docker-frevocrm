FROM centos
LABEL maintainer "takemi.ohama <takemi.ohama@gmail.com>"

RUN yum install -y epel-release
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum update -y 
RUN yum install -y --enablerepo=remi-php56 bsdtar httpd php php-xml \
    php-pear-MDB2-Driver-mysqli wget curl git sudo mysql-client 
RUN yum clean all 

WORKDIR /opt
RUN chmod g+ws /opt
RUN git clone https://github.com/takemi-ohama/frevocrm.git
RUN chown apache.users -R /opt/frevocrm 
RUN rm -rf /var/www/html && ln -s /opt/frevocrm /var/www/html

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
