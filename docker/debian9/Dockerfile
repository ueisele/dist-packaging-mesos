FROM debian:stretch
LABEL maintainer="uwe.eisele@online.de"

RUN apt-get update && \
    apt-get upgrade -y && \ 
    apt-get install -y  ruby ruby-dev python-dev autoconf automake git make libssl-dev libcurl3 libtool \
        openjdk-8-jdk \
        build-essential python-dev python-six python-virtualenv libcurl4-openssl-dev libsasl2-dev libsasl2-modules maven libapr1-dev libsvn-dev zlib1g-dev && \
    apt-get autoremove -y && \
    apt-get clean

ENV VERSION=1.5.0 MAKEFLAGS=-j8 MAINTAINER="Uwe Eisele <uwe.eisele@online.de>"
WORKDIR /mesos-deb-packaging
CMD ./build_mesos --repo https://git-wip-us.apache.org/repos/asf/mesos.git?ref=${VERSION}