@ECHO ON

set STAN_THREADS=TRUE
set TBB_INTERFACE_NEW=true
set TBB_INC=%PREFIX%/include/
set TBB_LIB=%PREFIX%/lib/
set PRECOMPILED_HEADERS=false
set CXXFLAGS=-I%LIBRARY_INC% -I%LIBRARY_INC%/eigen3

dir %LIBRARY_INC%

mingw32-make -f Makefile.conda conda -j1
if errorlevel 1 exit 1

python -m poetry build
if errorlevel 1 exit 1

python -m pip install dist/*.whl
if errorlevel 1 exit 1
