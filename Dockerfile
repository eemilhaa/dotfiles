FROM docker.io/library/archlinux:latest

RUN pacman -Syyu --noconfirm
RUN pacman-key --init
RUN pacman -S --noconfirm \
    curl \
    git \
    helix \
    neofetch \
    nodejs \
    openssh \
    python \
    python-pip \
    pyright \
    starship \
    zellij \
    zsh

# Rust
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init \
#     && sh rustup-init --default-toolchain nightly --component rust-analyzer-preview -y \
#     # && zsh -c "rustup component remove rust-docs" \
#     # && zsh -c "cargo install lsd rm-improved" \
#     && rm rustup-init

# RUN git clone --depth=1 https://github.com/...
COPY . /dotfiles/

RUN mkdir -p ~/.config

# helix
RUN ln -s /dotfiles/confs/helix ~/.config/
# zellij
RUN ln -s /dotfiles/confs/zellij ~/.config/
# zsh
RUN ln -s /dotfiles/confs/zsh/.zshrc ~/.zshrc \
    && chsh -s /bin/zsh
# starship
RUN ln -s /dotfiles/confs/starship/starship.toml ~/.config/starship.toml

# git
RUN git config --global user.name "eemilhaa" \
    && git config --global user.email "eemil.haapanen@gmail.com" \
    && git config --global --add safe.directory /root/work

WORKDIR /root/work

CMD [ "/bin/zsh" ]
