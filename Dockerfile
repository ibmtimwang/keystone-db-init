FROM docker.io/centos:7
MAINTAINER Adam Young <adam@younglogic.com>
 
RUN yum install -y centos-release-openstack-stein &&\
    yum update -y &&\
    yum -y install openstack-keystone mariadb openstack-utils  &&\
    yum -y clean all


RUN chmod o+rw /etc/keystone/keystone.conf
RUN chmod o+w /var/log/keystone/keystone.log

COPY ./keystone-configure.sql /
COPY ./configure_keystone.sh /
USER keystone
CMD /configure_keystone.sh
