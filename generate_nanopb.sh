#!/usr/bin/env bash

cp -v nanopb-${NANOPB_VER}/pb*.? host_mnt/
cd host_mnt
../nanopb-${NANOPB_VER}/generator/protoc --nanopb_out=. *.proto > nanopb_out.log 2>&1
../nanopb-${NANOPB_VER}/generator/protoc --python_out=. *.proto > python_out.log 2>&1
