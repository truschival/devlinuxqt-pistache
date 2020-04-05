Container for QT5/QML applications with libpistache-C++ and python3.

Container is based on 
[ruschi/devlinuxqtquick2:latest](https://hub.docker.com/repository/docker/ruschi/devlinuxqtquick2)
and [ruschi/devbusterbase](https://hub.docker.com/repository/docker/ruschi/devbusterbase)

So far there are no Debian packages for libpistache available, this docker file
builds it from source. Additionally python3 modules for pytest are included to
execute integration tests for openapi REST interfaces.
