# https://stackoverflow.com/questions/44876778/how-can-i-use-a-local-file-on-container

# docker run -v /Users/andy/mydata:/mnt/mydata myimage

# docker run -dit IMAGE

# docker run --detach --interactive --tty IMAGE

# docker exec -it CONTAINER bash

# docker stop CONTAINER

# docker run -it --rm  --mount type=volume,dst=/home/docker,volume-driver=local,volume-opt=type=none,volume-opt=o=bind,volume-opt=device=$PWD/tmp1 nanopb:latest

# removecontainers() {
#     docker stop $(docker ps -aq)
#     docker rm $(docker ps -aq)
# }

docker container ls devtest

docker volume rm nanopb_vol

docker volume create --driver local \
      --opt type=none \
      --opt device=$PWD/host_mnt \
      --opt o=bind \
      nanopb_vol

docker build -t nanopb:latest .

docker run -d \
  --name devtest \
  --volume nanopb_vol:/home/docker/host_mnt \
  nanopb:latest

# docker exec -it devtest bash

