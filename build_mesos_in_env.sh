#!/bin/bash
set -e
pushd . > /dev/null
cd $(dirname ${BASH_SOURCE[0]})
CWD_ROOT=`pwd`
BUILD_VERSION=`git describe --tags --dirty --abbrev=7`
popd > /dev/null

function prepare() {
    local build_distribution=${1:?'Requires build distribution as first parameter.'}
    (cd ${CWD_ROOT} && make clean && make dist.tar.gz)
    docker build --pull -t dist-packaging-mesos/${build_distribution}:${BUILD_VERSION} -f ${CWD_ROOT}/env/${build_distribution}.Dockerfile ${CWD_ROOT}/env/
}

function build_mesos() {
    local build_distribution=${1:?'Requires build distribution as first parameter.'}
    local mesos_version=${2:-1.5.0}
    local container_name=dist-packaging-mesos.mesos-${mesos_version}.${build_distribution}
    docker run --name ${container_name} -e MAKEFLAGS=-j8 -e MAINTAINER="Uwe Eisele <uwe.eisele@online.de>" dist-packaging-mesos/${build_distribution}:${BUILD_VERSION} \
        --repo https://git-wip-us.apache.org/repos/asf/mesos.git?ref=${mesos_version} --build-version ${BUILD_VERSION} --rename
    docker cp ${container_name}:/work/release/ ${CWD_ROOT}/
    docker rm ${container_name}
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    prepare "$@"
    build_mesos "$@"
fi