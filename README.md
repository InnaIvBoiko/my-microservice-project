# My own microservice project

A learning project for the **"DevOps CI/CD"** course.

## Goal

Practice Git/GitHub fundamentals and Linux system administration with Bash scripting.

## Lesson 3 — Linux Administration

This branch (`lesson-3`) contains [install_dev_tools.sh](install_dev_tools.sh), a Bash script
that automates the installation of the core tools a DevOps engineer needs on a fresh
**Ubuntu / Debian** machine:

- **Docker Engine**
- **Docker Compose** (installed as the `docker compose` plugin)
- **Python 3.9+** (with `pip` and `venv`)
- **Django** (installed via `pip`)

### Key features

- **Idempotent** — each tool is checked before installation, so re-running the script
  never reinstalls anything that is already present.
- **Safe by default** — runs with `set -euo pipefail` so it stops on the first error.
- **No-root friendly** — automatically uses `sudo` when not run as root, and adds the
  current user to the `docker` group so Docker can run without `sudo` after re-login.
- **Clear output** — colored `[INFO]` / `[WARN]` / `[ERROR]` log messages.

### Requirements

- Ubuntu or Debian (uses `apt-get`)
- `sudo` privileges (or run as root)
- Internet access (to fetch Docker's repository and pip packages)

### Usage

Make the script executable:

```bash
chmod u+x install_dev_tools.sh
```

Run it:

```bash
./install_dev_tools.sh
```

The script will install any missing tools and skip the ones already present. When it
finishes, you can verify the installation:

```bash
docker --version
docker compose version
python3 --version
python3 -m django --version
```

> **Note:** After the first install, log out and back in (or run `newgrp docker`) so the
> `docker` group membership takes effect and you can run Docker without `sudo`.
