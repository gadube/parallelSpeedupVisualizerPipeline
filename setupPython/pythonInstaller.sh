#!/bin/bash

VERSION=3.7.12
PYTHON_ARCHIVE=Python-$VERSION.tgz 
INSTALL_DIR=/home/$(whoami)/.local/Python-$VERSION

[ -d $INSTALL_DIR ] && echo "Python-$VERSION Already Installed!" && exit 0;

pushd ./

wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz
tar -xvf $PYTHON_ARCHIVE

cd Python-$VERSION
mkdir -p $INSTALL_DIR
./configure --prefix=$INSTALL_DIR
make
make install

echo "Python-$VERSION now lives at /home/$(whoami)/.local/Python-$VERSION"

popd
