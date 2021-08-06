#!/usr/bin/env bash

cp -v nanopb-${NANOPB_VER}/pb*.? host_mnt/
nanopb-${NANOPB_VER}/generator/protoc --nanopb_out=. host_mnt/*.proto > host_mnt/nanopb_out.log 2>&1
nanopb-${NANOPB_VER}/generator/protoc --python_out=. host_mnt/*.proto > host_mnt/python_out.log 2>&1
