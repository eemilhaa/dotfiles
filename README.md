# dotfiles

<img align="right" width="50%" src="https://github.com/user-attachments/assets/67e7b38a-7a82-4bf0-b230-3ac6aaf6e398" alt="Screenshot">

This repo contains my configuration files for Linux. It also hosts a portable
version of my command-line environment as a container image.

### Install

Clone the repo to `~/dotfiles`. Setup all configs with:

```console
bash scripts/symlink.sh
```

Get packages for fedora:

```console
dnf install $(cat pkgs/fedora.txt)
```

or for atomic fedora:

```console
rpm-ostree install --allow-inactive --idempotent $(cat pkgs/fedora.txt)
```

### Container

A container image with the command-line tools & their configs gets built
automatically once a week with a github action.

It works as a portable development environment wherever the container can be
run:

```console
podman run -it --rm -v <your/working/dir>:/root/work/ ghcr.io/eemilhaa/dotfiles:main
```

Or, as a base for a more integrated environment with Distrobox:

```console
distrobox create -n <name> --image ghcr.io/eemilhaa/dotfiles:main
```
