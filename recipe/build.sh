#!/bin/bash

set -ex

export TBB_CXX_TYPE=${c_compiler}
export STAN_THREADS=True

make -j1

${PYTHON} -m pip install --no-deps .
