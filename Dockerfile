FROM ruschi/devlinuxqtquick2:latest
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
    python3-pytest python-pytest \
    python3-pytest-cov \
    python3-pytest-runner python-pytest-runner \
    python3-certifi python-certifi\
    python3-urllib3 python-urllib3 \
    python3-setuptools python-setuptools\
    python3-dateutil python-dateutil \
    python3-six python-six \
    python3-requests python-requests \
    python3-git

# back to normal user
USER builduser
WORKDIR /home/builduser