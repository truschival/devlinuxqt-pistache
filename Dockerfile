FROM ghcr.io/truschival/devlinuxqtquick2:v11.2.0-1
MAINTAINER Thomas Ruschival <t.ruschival@gmail.com>

# Setup language environment and encoding
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV PISTACHE_COMMIT 73f248acd6db4c53

# Install stuff as root
USER root

# Build and install pistache - we don't have a Debian package :(
RUN mkdir -p pistache && cd pistache; \
    git clone https://github.com/oktal/pistache.git pistache_src ;\
    cd pistache_src && git reset --hard $PISTACHE_COMMIT ;\
    mkdir build && cd build;\
    cmake cmake -DPISTACHE_USE_SSL=On ../ ;\
    cmake --build . --parallel --target install ;\
    ldconfig

# packages for pytest setup
RUN apt-get update && apt-get install -y \
    python3-certifi  \
    python3-dateutil  \
    python3-git \
    python3-pip \
    python3-pytest \
    python3-pytest-cov \
    python3-pytest-runner \
    python3-pytest-timeout \
    python3-requests \
    python3-setuptools \
    python3-six  \
    python3-urllib3  \
    python-pytest-runner

# back to normal user
USER builduser
WORKDIR /home/builduser
