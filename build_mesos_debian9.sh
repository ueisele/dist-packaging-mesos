#!/bin/bash
set -e
pushd . > /dev/null
cd $(dirname ${BASH_SOURCE[0]})
CWD_ROOT=`pwd`
popd > /dev/null

function prepare() {
    docker build -t mesos-packaging:debian9 ${CWD_ROOT}/docker/debian9
}

function build_mesos() {
    local version=${1:-1.5.0}
    docker run --rm -v ${CWD_ROOT}:/mesos-deb-packaging -e VERSION=${version} mesos-packaging:debian9
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    #prepare
    build_mesos "$@"
fi