FROM ubuntu:20.04

# Installing basic packages
RUN apt-get update
RUN apt-get install -yq wget

# Create user
RUN apt-get install -yq sudo
RUN adduser --disabled-password --gecos '' docker
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN adduser docker sudo
USER docker

# Install Protobuf compiler
ARG PB_VER
WORKDIR /home/docker
RUN sudo apt-get install -yq autoconf automake libtool curl make g++ unzip
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v${PB_VER}/protobuf-python-${PB_VER}.tar.gz
RUN tar -xvf protobuf-python-${PB_VER}.tar.gz
WORKDIR /home/docker/protobuf-${PB_VER}
RUN ./autogen.sh
RUN ./configure 
RUN make
RUN sudo make install
RUN sudo ldconfig

# Install NanoPB
ARG NANOPB_VER
WORKDIR /home/docker
RUN sudo apt-get install -yq python3-pip
RUN pip3 install protobuf
RUN wget https://github.com/nanopb/nanopb/archive/refs/tags/${NANOPB_VER}.tar.gz
RUN tar -xvf ${NANOPB_VER}.tar.gz
RUN mkdir host_mnt
COPY generate_nanopb.sh /home/docker

# Generate nanopb message structs
CMD ["bash", "generate_nanopb.sh"]
