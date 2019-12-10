FROM docker.io/centos:7
MAINTAINER Adam Young <adam@younglogic.com>
 
RUN yum install -y centos-release-openstack-stein &&\
    yum update -y &&\
    yum -y install openstack-keystone mariadb openstack-utils  &&\
    yum -y clean all


RUN chmod 777 /etc/keystone/keystone.conf
RUN chmod a+w /var/log/keystone/keystone.log
COPY ./keystone-configure.sql /
COPY ./configure_keystone.sh /
CMD /configure_keystone.sh keystone-mariadb 3306
