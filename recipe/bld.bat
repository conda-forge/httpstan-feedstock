@ECHO ON

make
if errorlevel 1 exit 1

python -m pip install . --no-deps
if errorlevel 1 exit 1
