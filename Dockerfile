# Setup container with Ubuntu 20.04 image
FROM ubuntu:20.04

# Set the working directory to /
WORKDIR /

# expose ports for openvswitch-switch
EXPOSE 6633 6653 6640

COPY ENTRYPOINT.sh /

# Update container image
RUN apt-get update -y && \
    apt-get autoremove -y && \
    apt-get install --no-install-recommends lsb-release sudo \
    -y zip unzip wget git ca-certificates \
    curl iproute2 iputils-ping net-tools \
    tcpdump vim x11-xserver-utils xterm && \
    update-ca-certificates && \
    chmod +x ENTRYPOINT.sh && alias python=python3 && \
    git clone --depth 1 https://github.com/mininet/mininet.git && \
    cd mininet && ./util/install.sh && cd / &&\
    git clone https://github.com/named-data/mini-ndn.git && \
    cd mini-ndn && \
    git pull https://github.com/dulalsaurab/mini-ndn-11th-ndn-hackathon.git && \
    ./install.sh -a && cd / && \
    rm -rf /var/lib/apt/lists/*

# Change the working directory to /mini-ndn
WORKDIR /mini-ndn

ENTRYPOINT ["/ENTRYPOINT.sh"]