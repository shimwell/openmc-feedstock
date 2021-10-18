#!/bin/bash
set -x
set -e

# Build and install DAGMC
cd vendor
cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      ..
make -j "${CPU_COUNT}"
make install
cd ..

# Build and install OpenMC executable
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_BUILD_TYPE=Release \
      -DHDF5_ROOT="${PREFIX}" \
      -Ddagmc=ON \
      -DDAGMC_ROOT="vendor/${PREFIX}" \
      ..
make -j "${CPU_COUNT}"
make install
cd ..

# Install Python API
$PYTHON -m pip install . --no-deps -vv
