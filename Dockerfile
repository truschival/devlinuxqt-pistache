FROM ghcr.io/truschival/devlinuxqtquick2:latest
LABEL maintainer="Thomas Ruschival <t.ruschival@gmail.com>" \
      org.opencontainers.image.source="https://github.com/truschival/devlinuxqt-pistache"

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

USER root

# In Debian Trixie, libpistache-dev is available directly from Debian repositories
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        libpistache-dev \
        python3 \
        python3-pip \
        python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch to builduser and prepare Python virtual environment
USER builduser
WORKDIR /home/builduser

# Create a virtual environment for builduser so pip installs work cleanly without PEP 668 errors
RUN python3 -m venv /home/builduser/.venv && \
    /home/builduser/.venv/bin/pip install --no-cache-dir --upgrade pip setuptools wheel && \
    /home/builduser/.venv/bin/pip install --no-cache-dir \
        pytest \
        pytest-cov \
        requests \
        GitPython

# Ensure the virtual environment is in PATH for all subsequent commands
ENV PATH="/home/builduser/.venv/bin:$PATH" \
    VIRTUAL_ENV="/home/builduser/.venv"
