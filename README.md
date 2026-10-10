# devlinuxqt-pistache

Container for Qt5/QML applications with Pistache C++ REST framework and Python 3.

The container is built on top of:
- `ghcr.io/truschival/devlinuxqtquick2:latest`
- `ghcr.io/truschival/devlinuxbase:latest` (Debian Trixie)

In Debian Trixie, `libpistache-dev` is installed directly from the official Debian package repositories.
A pre-configured Python 3 virtual environment is provided at `/home/builduser/.venv` and enabled in `PATH`, allowing `pip` package installation without system package conflicts (PEP 668).
