FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    wget \
    curl \
    python3 \
    python3-pip \
    cmake \
    automake \
    autoconf \
    libtool \
    ca-certificates \
    software-properties-common \
    pkg-config \
    python3-setuptools \
    nano \
    binutils \
    unzip \
    xz-utils \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Clone CompDiff repository
RUN git clone https://github.com/KabilanMA/CompDiff.git /workspace/CompDiff

WORKDIR /workspace/CompDiff

CMD ["/bin/bash"]
