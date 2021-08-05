#!/usr/bin/env bash

nanopb-0.4.5/generator/protoc --nanopb_out=. host_mnt/*.proto > host_mnt/nanopb_out.log 2>&1
nanopb-0.4.5/generator/protoc --python_out=. host_mnt/*.proto > host_mnt/python_out.log 2>&1
