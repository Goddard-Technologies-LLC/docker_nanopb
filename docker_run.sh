#!/usr/bin/env bash

# debug docker
# docker run --detach --interactive --tty --volume nanopb_generator_volume:/home/docker/host_mnt nanopb:latest bash
# docker exec -it CONTAINER bash

NANOPB_LOG=proto/nanopb_out.log
PYTHON_LOG=proto/python_out.log

CONTAINER_NAME=nanopb_generator
VOL_NAME=nanopb_generator_volume
PROTOPATH=$PWD/proto

docker container rm $CONTAINER_NAME 

docker volume rm $VOL_NAME

docker volume create --driver local \
      --opt type=none \
      --opt device=$PROTOPATH \
      --opt o=bind \
      $VOL_NAME

docker build --build-arg PB_VER=3.17.3 --build-arg NANOPB_VER=0.4.5 --tag nanopb:latest .

docker run \
  --name $CONTAINER_NAME \
  --volume $VOL_NAME:/home/docker/host_mnt \
  nanopb:latest

if [ -s $PYTHON_LOG ]
then
  cat $PYTHON_LOG
fi

if [ -s $NANOPB_LOG ]
then
  cat $NANOPB_LOG
fi
