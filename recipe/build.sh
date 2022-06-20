#!/bin/bash

set -ex

export STAN_THREADS=True
export TBB_INTERFACE_NEW=true
export TBB_INC=${PREFIX}/include/
export TBB_LIB=${PREFIX}/lib/
export PRECOMPILED_HEADERS=false

#echo "prefix is " ${PREFIX}

make -f Makefile.conda conda -j1

${PYTHON} -m poetry build
${PYTHON} -m pip install dist/*.whl -vv
