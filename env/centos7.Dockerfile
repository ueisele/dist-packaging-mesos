FROM centos:7

COPY yum-wandisco-svn.repo /etc/yum.repos.d/wandisco-svn.repo

RUN yum update -y && \
    yum install -y tar wget git && \
    wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo && \
    yum install -y epel-release && \
    yum groupinstall -y "Development Tools" && \
    yum install -y apache-maven python-devel python-six python-virtualenv java-1.8.0-openjdk-devel zlib-devel libcurl-devel openssl-devel cyrus-sasl-devel cyrus-sasl-md5 apr-devel subversion-devel apr-util-devel && \
    yum install -y ruby ruby-devel python-devel autoconf automake git make openssl-devel libcurl libtool && \
    yum autoremove -y && \
    yum clean all && \
    gem install fpm

ADD dist.tar.gz /work
WORKDIR /work
ENTRYPOINT [ "./build_mesos" ]