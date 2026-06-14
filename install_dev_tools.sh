#!/usr/bin/env bash
#
# install_dev_tools.sh
#
# Automated installer for common DevOps tooling on Ubuntu / Debian:
#   - Docker Engine
#   - Docker Compose (plugin)
#   - Python 3.9+
#   - Django (via pip)
#
# The script is idempotent: each tool is checked before installation,
# so re-running it will not reinstall anything that is already present.

set -euo pipefail

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

log()  { echo -e "\033[1;32m[INFO]\033[0m  $*"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m  $*"; }
err()  { echo -e "\033[1;31m[ERROR]\033[0m $*" >&2; }

# Run a command with sudo when not already root.
SUDO=""
if [[ "${EUID}" -ne 0 ]]; then
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"
    else
        err "This script needs root privileges or sudo to install packages."
        exit 1
    fi
fi

# Check whether a command exists in PATH.
has() { command -v "$1" >/dev/null 2>&1; }

# ---------------------------------------------------------------------------
# Pre-flight checks
# ---------------------------------------------------------------------------

if ! has apt-get; then
    err "apt-get not found. This script supports Ubuntu / Debian only."
    exit 1
fi

log "Updating package index..."
${SUDO} apt-get update -y

log "Installing base prerequisites..."
${SUDO} apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# ---------------------------------------------------------------------------
# Docker Engine
# ---------------------------------------------------------------------------

install_docker() {
    if has docker; then
        log "Docker is already installed: $(docker --version)"
        return
    fi

    log "Installing Docker Engine..."

    # Add Docker's official GPG key.
    ${SUDO} install -m 0755 -d /etc/apt/keyrings
    if [[ ! -f /etc/apt/keyrings/docker.gpg ]]; then
        curl -fsSL "https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg" \
            | ${SUDO} gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        ${SUDO} chmod a+r /etc/apt/keyrings/docker.gpg
    fi

    # Set up the repository.
    local arch codename os_id
    arch="$(dpkg --print-architecture)"
    codename="$(. /etc/os-release && echo "${VERSION_CODENAME}")"
    os_id="$(. /etc/os-release && echo "$ID")"
    echo \
        "deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/${os_id} ${codename} stable" \
        | ${SUDO} tee /etc/apt/sources.list.d/docker.list >/dev/null

    ${SUDO} apt-get update -y
    ${SUDO} apt-get install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin

    # Allow the current user to run docker without sudo (effective on next login).
    if [[ -n "${SUDO}" ]] && getent group docker >/dev/null 2>&1; then
        ${SUDO} usermod -aG docker "${USER}" || true
        warn "Added ${USER} to the 'docker' group. Log out and back in for it to take effect."
    fi

    log "Docker installed: $(docker --version)"
}

# ---------------------------------------------------------------------------
# Docker Compose
# ---------------------------------------------------------------------------

install_docker_compose() {
    # Modern Docker ships Compose as a plugin: `docker compose`.
    if docker compose version >/dev/null 2>&1; then
        log "Docker Compose is already installed: $(docker compose version)"
        return
    fi

    # Fall back to the standalone `docker-compose` binary if the plugin is absent.
    if has docker-compose; then
        log "Docker Compose (standalone) is already installed: $(docker-compose --version)"
        return
    fi

    log "Installing Docker Compose plugin..."
    ${SUDO} apt-get install -y docker-compose-plugin

    if docker compose version >/dev/null 2>&1; then
        log "Docker Compose installed: $(docker compose version)"
    else
        warn "Could not verify Docker Compose installation."
    fi
}

# ---------------------------------------------------------------------------
# Python 3.9+
# ---------------------------------------------------------------------------

# Compare the installed python3 version against the required minimum (3.9).
python_version_ok() {
    has python3 || return 1
    python3 - <<'PY'
import sys
sys.exit(0 if sys.version_info >= (3, 9) else 1)
PY
}

install_python() {
    if python_version_ok; then
        log "Python is already installed: $(python3 --version)"
    else
        log "Installing Python 3..."
        ${SUDO} apt-get install -y python3 python3-pip python3-venv
        log "Python installed: $(python3 --version)"
    fi

    # Ensure pip is available for the Django step.
    if ! has pip3 && ! python3 -m pip --version >/dev/null 2>&1; then
        log "Installing pip for Python 3..."
        ${SUDO} apt-get install -y python3-pip
    fi
}

# ---------------------------------------------------------------------------
# Django
# ---------------------------------------------------------------------------

install_django() {
    if python3 -m django --version >/dev/null 2>&1; then
        log "Django is already installed: $(python3 -m django --version)"
        return
    fi

    log "Installing Django via pip..."
    # --break-system-packages is needed on newer Debian/Ubuntu (PEP 668) for a
    # global install; it is ignored gracefully on older pip versions.
    if python3 -m pip install --user Django 2>/dev/null \
        || python3 -m pip install --user --break-system-packages Django; then
        log "Django installed: $(python3 -m django --version)"
    else
        err "Failed to install Django."
        return 1
    fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

main() {
    log "Starting DevOps tooling installation..."
    install_docker
    install_docker_compose
    install_python
    install_django
    log "All tools are installed and ready to use."
}

main "$@"
