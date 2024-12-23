# dotfiles

<img align="right" width="50%" src="https://github.com/user-attachments/assets/bd8d0427-aa58-4599-9acb-b5e2c0e3f234" alt="Screenshot">

Sway-based graphical environment and various cli tools.

### Install

Clone the repo to `~/dotfiles`. Setup all configs with:

```console
bash scripts/symlink.sh
```

Get packages for fedora:

```
dnf install $(cat pkgs/rpm.txt)
```

or for atomic fedora:

```
rpm-ostree install --allow-inactive --idempotent $(cat pkgs/rpm.txt)
```

### Container

Basic cli utilities (shell, multiplexer, editor, some language tooling etc.) and
their configs are bundled into a container image. It gets built automatically
once a week with a github action.

The image works as a portable cli environment wherever the container can be run:

```console
podman run -it --rm -v <your/working/dir>:/root/work/ ghcr.io/eemilhaa/dotfiles:main
```

Or as a base for a more integrated environment with Distrobox:

```console
distrobox create -n <name> --image ghcr.io/eemilhaa/dotfiles:main
```
