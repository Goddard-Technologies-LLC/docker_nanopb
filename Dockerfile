FROM ubuntu:20.04

# Installing basic packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get clean
RUN apt-get autoremove --purge

# Create user
RUN apt-get install -yq sudo
RUN adduser --disabled-password --gecos '' docker
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN adduser docker sudo
USER docker

# Add ssh private key into container
RUN sudo apt-get install -yq ssh
ARG SSH_PRIVATE_KEY
RUN mkdir $HOME/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa
RUN chmod 600 ~/.ssh/id_rsa
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

# Install protobuf compiler
WORKDIR /home/docker
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protobuf-python-3.17.3.tar.gz
RUN tar -xvf protobuf-python-3.17.3.tar.gz
RUN cd protobuf-3.17.3

WORKDIR /home/docker/protobuf-3.17.3
RUN sudo apt-get install -yq autoconf automake libtool curl make g++ unzip
RUN ./autogen.sh
RUN ./configure 
RUN make
RUN sudo make install
RUN sudo ldconfig

# Install NanoPB
RUN sudo apt-get install -yq python3-pip
RUN pip3 install protobuf
WORKDIR /home/docker
RUN wget https://github.com/nanopb/nanopb/archive/refs/tags/0.4.5.tar.gz
RUN tar -xvf 0.4.5.tar.gz 
WORKDIR nanopb-0.4.5/examples/simple
RUN make
WORKDIR /home/docker
RUN mkdir host_mnt
COPY generate_nanopb.sh /home/docker

CMD ["bash", "generate_nanopb.sh"]