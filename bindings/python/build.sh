#!/bin/bash
set -e

# This script is used to build the Python bindings for the C++ library.
# It is intended to be run from the root of the repository.

# if is macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # install openblas
    brew install openblas
    export LDFLAGS="-L./lib -L/opt/homebrew/opt/openblas/lib"
    export CPPFLAGS="-I./include -I/opt/homebrew/opt/openblas/include"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # install openblas
    sudo apt-get install libopenblas-dev
    export LDFLAGS="-L./lib"
    export CPPFLAGS="-I./include"
else
#    # install openblas
    export LDFLAGS="-L./lib"
    export CPPFLAGS="-I./include"
fi

# Build the whisper library
if [[ "$OSTYPE" == "darwin"* ]]; then
  GGML_OPENBLAS=1 make clean prepare d_lib s_lib
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  GGML_CUDA=1 make clean prepare d_lib s_lib
else
  make clean prepare d_lib s_lib
fi

# Build the Python bindings
python whisper_cffi_build.py

python test_cffi_binding.py