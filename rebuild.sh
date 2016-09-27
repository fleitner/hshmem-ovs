#!/bin/bash

set -e

DPDK_REPO=/home/fleitner/repo/hshmem-dpdk
if [ -d _build ]; then
    rm -rf _build
fi

mkdir _build
./boot.sh
cd _build
LDFLAGS="-ldl" ../configure --with-dpdk=${DPDK_REPO}/x86_64-native-linuxapp-gcc  --disable-ssl
rm -f errors
make -j16 2> errors
echo $?
if [ -f errors ]; then
    echo "======> Errors"
    cat errors
    echo "<====== Errors"
fi

