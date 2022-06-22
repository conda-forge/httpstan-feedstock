#!/bin/bash
set -ex

# Choose the stanc implementation based on OS.
# The source files are specified in the meta.yaml file
mkdir build
if [ "$(uname -s)" == "Darwin" ]; then
	mv archives/mac-stanc httpstan/stanc
elif [ "$(uname -s)" == "Linux" ]; then
	mv archives/linux-stanc httpstan/stanc
else
	echo "Could not identify OS"
	exit 1
fi

# The stanc binary transpiles stan to cpp and needs to be executable
chmod u+x httpstan/stanc

# Move stan header files to appropriate locations in httpstan/include
mkdir httpstan/include
mv archives/stan/src/stan httpstan/include
mv archives/math/stan/math.hpp httpstan/include/stan
mv archives/math/stan/math httpstan/include/stan
rm -rf archives

# Precompile the service module to speed up model compilation
${CXX} \
	${CXXFLAGS} \
	$(pkg-config --cflags python3 eigen3) \
	$(python -m pybind11 --includes) \
	-Ihttpstan/include \
	-Ihttpstan \
	-I${PREFIX}/include \
	-DBOOST_DISABLE_ASSERTS \
	-DBOOST_PHOENIX_NO_VARIADIC_EXPRESSION \
	-DSTAN_THREADS \
	-D_REENTRANT \
	-D_GLIBCXX_USE_CXX11_ABI=0 \
	-DTBB_INTERFACE_NEW \
	-DPRECOMPILED_HEADERS=0 \
	-fvisibility=hidden \
	-O3 -std=c++14 \
	-c httpstan/stan_services.cpp \
	-o httpstan/stan_services.o

${PYTHON} -m poetry build
${PYTHON} -m pip install dist/*.whl -vv
