#!/bin/bash

set -ex

#export STAN_THREADS=True
#export TBB_CXX_TYPE=${c_compiler}
#export TBB_INTERFACE_NEW=true
#export TBB_INC=${PREFIX}/include/
#export TBB_LIB=${PREFIX}/lib/
#export PRECOMPILED_HEADERS=false

#echo "prefix is " ${PREFIX}

#make conda -j1

$PYTHON -m poetry build
$PYTHON -m pip install dist/*.whl -vv
#$PYTHON -m pip install .
#$PYTHON -m pip install .

#python -c "import httpstan.model, asyncio; asyncio.run(httpstan.models.build_services_extension_module('data {}'))"
