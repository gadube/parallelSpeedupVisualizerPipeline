#!/bin/bash -e

# Path to Python >= 3.7
echo "Installing Python 3.7 if not already installed..."
PYTHON_HOME=$(tail -n 0 $(bash pythonInstaller.sh))

# Get path to this file
THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" ;


virtualEnvDir="${THIS_PATH}/virtualEnv" ;


echo "Setting up virtual environment..."
if ! test -d ${virtualEnvDir}/bin ; then
  mkdir -p ${virtualEnvDir} ;

  virtualenv --python=${PYTHON_HOME}/bin/python3 ${virtualEnvDir}

  source ${virtualEnvDir}/bin/activate ;

  pip install --upgrade pip ;

  # Change these installs to change dependencies needed
  pip install 'dash>=1.20.0'
  pip install 'numpy>=1.19.5'
  pip install 'plotly>=4.14.3'

else
  source ${virtualEnvDir}/bin/activate ;
fi
