#!/bin/bash

set -ex

export TBB_CXX_TYPE=${c_compiler}

make -j2

${PYTHON} -m pip install --no-deps .
