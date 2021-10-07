#/bin/bash

#Edit this line to add benchmarks to compile
BENCHMARKS="PARSEC3"

THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"
BENCHMARKS_BASE_DIR=$(find -O3 $HOME -type d -name wholeprogram_benchmarks)
GO_PATH=/project/go/go_1.13.7
LLVM_PATH=/project/extra/llvm/9.0.0
NOELLE_PATH=$(find -O3 $HOME -type d -name noelle | grep -v src)

pushd ./ > /dev/null

# Check that needed software is enabled
[ -z "$( go version 2> /dev/null )" ] \
  && echo "Enable go first: 'source $GO_PATH/enable'"

[ -z "$( llvm-config --version 2> /dev/null )" ] \
  && echo "Enable LLVM first: 'source $LLVM_PATH/enable'"


[ -z $NOELLE_PATH ] && echo "Cannot find Noelle Directory..."
[ -z "$( noelle-config 2> /dev/null )" ] \
  && echo "Enable Noelle first: 'source $NOELLE_PATH/enable'"

if [ -z "$( noelle-config 2> /dev/null )" ] || [ -z "$( llvm-config --version 2> /dev/null )" ] || [ -z "$( go version 2> /dev/null )" ]; then
  exit 1;
fi

# If benchmarks directory doesn't exist, create it.
[ ! -d "$BENCHMARKS_BASE_DIR" ] && (echo "wholeprogram_benchmarks directory does NOT exist... Cloning new one.." && git clone git@github.com:scampanoni/wholeprogram_benchmarks.git)
cd $BENCHMARKS_BASE_DIR && echo "In benchmarks base dir..."

# Clone repo of benchmarks from Zythos cluster if not already there
[ ! -d "BenchmarksBitcodes" ] \
  && git clone /project/benchmarks/repositories/BenchmarksBitcodes

# Compile the framework for gllvm
make

# Optimize, Create Binary, and Run all benchmarks
for X in $BENCHMARKS
do
  pushd ./ > /dev/null

  echo "Running for $X"
  cd build/$X
#  make
  $THIS_PATH/benchmarks/$X.sh

  popd > /dev/null
done

popd > /dev/null
