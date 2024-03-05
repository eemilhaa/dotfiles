# dotfiles

<img align="right" width="50%" src="https://github.com/eemilhaa/dotfiles/assets/70660230/a36b9697-65cf-42cf-bf86-cffcef97b2ad" alt="Screenshot">

My configurations for various things.
- GUI: Swaywm, Waybar, Fuzzel
- CLI: Zsh, Helix, Zellij and many more

### Install
To setup all configs:
```console
bash scripts/symlink.sh
```

### Container
Some generic cli utilities
(shell, multiplexer, editor, language tooling etc.)
along with their configs are bundled into a container image.
It gets built automatically once a week with a github action.

The image works as a portable cli environment wherever the container can be run:
```console
podman run -it --rm -v <your/working/dir>:/root/work/ ghcr.io/eemilhaa/dotfiles:main
```

Or as a base for a more integrated environment with Distrobox:
```console
distrobox create -n <name> --image ghcr.io/eemilhaa/dotfiles:main
```
