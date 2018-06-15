FROM centos
LABEL maintainer "takemi.ohama <takemi.ohama@gmail.com>"

RUN yum install -y epel-release yum-plugin-fastestmirror
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum update -y 
RUN yum install -y --enablerepo=remi-php56 bsdtar httpd php php-xml \
    php-pear-MDB2-Driver-mysqli wget curl git sudo mysql
RUN yum clean all 

WORKDIR /opt
RUN chmod g+ws /opt
RUN git clone https://github.com/takemi-ohama/frevocrm.git
RUN chown apache.users -R /opt/frevocrm 
RUN chmod g+w -R /opt/frevocrm
RUN rm -rf /var/www/html && ln -s /opt/frevocrm /var/www/html
RUN echo -e "display_errors=On\nmax_execution_time=900\nshort_open_tag=On\nlog_errors=Off\nerror_reporting=0" > /etc/php.d/50-frevocrm.ini

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
