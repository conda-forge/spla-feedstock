#!/bin/bash
set -ex

# Use separate build directories to avoid object file contamination
BUILD_DIR="build_${PKG_NAME}"

if [[ "${PKG_NAME}" == "spla-static" ]]; then
  BUILD_SHARED="OFF"
  SPLA_STATIC="ON"
else
  BUILD_SHARED="ON"
  SPLA_STATIC="OFF"
fi

cmake -B "${BUILD_DIR}" -S . \
  ${CMAKE_ARGS} \
  -GNinja \
  -DBUILD_SHARED_LIBS="${BUILD_SHARED}" \
  -DCMAKE_BUILD_TYPE="Release" \
  -DCMAKE_POSITION_INDEPENDENT_CODE="ON" \
  -DSPLA_BUNDLED_TEST_LIBS="OFF" \
  -DSPLA_FORTRAN="ON" \
  -DSPLA_GPU_BACKEND="OFF" \
  -DSPLA_OMP="OFF" \
  -DSPLA_STATIC="${SPLA_STATIC}"
cmake --build "${BUILD_DIR}" --parallel "${CPU_COUNT}"
cmake --install "${BUILD_DIR}"
