## What
My terminal setup, containerized.

![image](https://github.com/eemilhaa/kontti/assets/70660230/4ca023d3-6695-44ed-96ff-115a5219d7f0)

## Why
To have a cross-system command-line environment that works the same everywhere
and is always up to date.

## How
- Since its just a container, it should work wherever the container can be run.
- The container image is built and pushed automatically with a github action
  once a week -> no manual maintenance.

## What's in it
- Shell: zsh
- Editor: [Helix](https://github.com/helix-editor/helix)
- Terminal workspace and multiplexer: [Zellij](https://github.com/zellij-org/zellij)
- LSP and other tooling for:
  - Python
  - JS / TS
  - Rust
  - Latex
- And a lot more, see `Dockerfile` for everything

## How to run it
Running is as simple as:
```console
<docker/podman> run -it --rm ghcr.io/eemilhaa/kontti:main
```
To actually get something done, mount the directory you are working in as
a volume to the container and expose the necessary ports (or use the host
network).
