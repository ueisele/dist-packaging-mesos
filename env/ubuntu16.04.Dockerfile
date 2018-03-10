FROM ubuntu:16.04

RUN apt-get update && \
    apt-get upgrade -y && \ 
    apt-get install -y ruby ruby-dev python-dev autoconf automake git make libssl-dev libcurl3 libtool \
        openjdk-8-jdk \
        build-essential python-dev python-six python-virtualenv libcurl4-openssl-dev libsasl2-dev libsasl2-modules maven libapr1-dev libsvn-dev zlib1g-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    gem install fpm    

ADD dist.tar.gz /work
WORKDIR /work
ENTRYPOINT [ "./build_mesos" ]