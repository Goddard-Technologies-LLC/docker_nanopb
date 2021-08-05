#!/usr/bin/env bash


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

docker build -t nanopb:latest .

docker run -d \
  --name $CONTAINER_NAME \
  --volume $VOL_NAME:/home/docker/host_mnt \
  nanopb:latest
