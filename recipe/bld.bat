@ECHO ON

set STAN_THREADS=TRUE
mingw32-make -j%CPU_COUNT%
if errorlevel 1 exit 1

python -m pip install . --no-deps
if errorlevel 1 exit 1
