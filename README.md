## What's this?
A container image with some development tools (and other cli niceties) with
my configurations.

## Why?
To have a cross-system command-line environment that works the same everywhere
and is always up to date.

## How?
- Since its just a container, it should work wherever the container can be run.
- The container image is built and pushed automatically with a github action
  once a week -> no manual maintenance.

## What's in it?
- Shell: zsh
- Editor: [Helix](https://github.com/helix-editor/helix)
- Terminal workspace and multiplexer: [Zellij](https://github.com/zellij-org/zellij)
- Prompt: [Starship](https://github.com/starship/starship)
- LSP and other tooling for python and js/ts
- Latex
- And a lot more, see `Dockerfile` for everything

## How to run it?
Running is as simple as:
```
<docker/podman> run -it --rm ghcr.io/eemilhaa/kontti:main
```
To actually get something done, mount the directory you are working in as
a volume to the container and expose the necessary ports (or use the host
network).
