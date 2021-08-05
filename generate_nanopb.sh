#!/usr/bin/env bash

nanopb-0.4.5/generator/protoc --nanopb_out=. host_mnt/*.proto
nanopb-0.4.5/generator/protoc --python_out=. host_mnt/*.proto