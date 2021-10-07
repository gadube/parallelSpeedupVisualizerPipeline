#!/bin/bash -e

# Get path to this file
THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" ;

# Get python version number
DEFAULT_PYTHON_VERSION="Python-3.6.8.tgz"
PYTHON_ZIPFILE_SUFFIX=${$(ls Python*tgz 2> /dev/null):-}
PYTHON_ZIPFILE_NO_SUFFIX=${PYTHON_ZIPFILE_SUFFIX%.*tgz}
PYTHON_VERSION=${PYTHON_ZIPFILE_NO_SUFFIX#P*-}

virtualEnvDir="${THIS_PATH}/virtualEnv" ;

[[ $PYTHON_VERSION =~ [0-9]+[.][0-9]+[.][0-9]+ ]] && echo "SUCCESS" || echo "FAILURE"

# if ! test -d ${virtualEnvDir} ; then
#   mkdir ${virtualEnvDir} ;

#   virtualenv --python=/home/$(whoami)/.local/Python-${PYTHON_VERSION}
