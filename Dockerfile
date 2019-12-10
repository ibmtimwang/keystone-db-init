FROM docker.io/centos:7
MAINTAINER Adam Young <adam@younglogic.com>
 
RUN yum install -y centos-release-openstack-stein &&\
    yum update -y &&\
    yum -y install openstack-keystone mariadb openstack-utils  &&\
    yum -y clean all


RUN chown keystone:keystone /etc/keystone/keystone.conf
RUN chown keystone:keystone /var/log/keystone/keystone.log

COPY ./keystone-configure.sql /
COPY ./configure_keystone.sh /
USER keystone
CMD /configure_keystone.sh
