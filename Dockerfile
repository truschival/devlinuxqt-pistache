FROM ghcr.io/truschival/devlinuxqtquick2:v11.6
MAINTAINER Thomas Ruschival <t.ruschival@gmail.com>

# Setup language environment and encoding
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV PISTACHE_COMMIT ce251dfe8cd551380466f75bce79f3fdea5983f7

# Install stuff as root
USER root

# packages for pytest setup
# pistache builds better with meson in recent releases
RUN apt-get update && apt-get install -y \
    meson \
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
    python3-pytest-runner

# Build and install pistache - we don't have a Debian package :(
RUN mkdir -p pistache && cd pistache; \
    git clone https://github.com/oktal/pistache.git pistache_src ;\
    cd pistache_src; \
	git checkout $PISTACHE_COMMIT; \
    meson setup build \
      --buildtype=release \
      -DPISTACHE_USE_SSL=true \
      -DPISTACHE_BUILD_EXAMPLES=false \
      -DPISTACHE_BUILD_TESTS=false \
      -DPISTACHE_BUILD_DOCS=false;\
    meson compile -C build;\
    meson install -C build;\
    ldconfig

# back to normal user
USER builduser
WORKDIR /home/builduser
