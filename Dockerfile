FROM docker.io/library/archlinux:latest

RUN pacman -Syyu --noconfirm \
    && pacman-key --init \
    && pacman -S --noconfirm \
        curl \
        git \
        helix \
        neofetch \
        nodejs \
        npm \
        openssh \
        python \
        python-pip \
        pyright \
        starship \
        zellij \
        zsh

RUN git clone --depth=1 https://github.com/eemilhaa/kontti /dotfiles \
    && mkdir -p ~/.config

RUN ln -s /dotfiles/confs/helix ~/.config/ \
    && ln -s /dotfiles/confs/zellij ~/.config/ \
    && ln -s /dotfiles/confs/zsh/.zshrc ~/.zshrc && chsh -s /bin/zsh \
    && ln -s /dotfiles/confs/starship/starship.toml ~/.config/starship.toml

# Rust
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init \
#     && sh rustup-init --default-toolchain nightly --component rust-analyzer-preview -y \
#     # && zsh -c "rustup component remove rust-docs" \
#     # && zsh -c "cargo install lsd rm-improved" \
#     && rm rustup-init

# node lsp
RUN npm install -g typescript typescript-language-server
# poetry
RUN curl -sSL https://install.python-poetry.org | python3 -


# git
RUN git config --global user.name "eemilhaa" \
    && git config --global user.email "eemil.haapanen@gmail.com" \
    && git config --global --add safe.directory /root/work

WORKDIR /root/work

CMD [ "/bin/zsh" ]
