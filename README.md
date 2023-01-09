# kontti
This is a container with some development tools and their configurations.
The goal is to have a cross-system development environment that works the same
everywhere and is always up to date. 
- Since its just a container, it should work wherever the container can be run
  (Tested only on linux)
- No manual maintenance - the container image is built and pushed automatically
  with a github action once a week.

## Tools
- Shell: zsh
- Editor: [Helix](https://github.com/helix-editor/helix)
- Terminal workspace and multiplexer: [Zellij](https://github.com/zellij-org/zellij)
- Prompt: [Starship](https://github.com/starship/starship)
- LSP and other tooling for python and js/ts

## Running the container
Running is as simple as:
```
<docker/podman> run -it --rm ghcr.io/eemilhaa/kontti:main
```
To actually get something done, mount the directory you are working in as
a volume to the container and expose the necessary ports (or use the host
network).
