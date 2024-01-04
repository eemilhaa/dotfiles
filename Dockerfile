FROM docker.io/library/archlinux:latest

# env
ENV TZ=Europe/Helsinki
ENV HOST=container
ENV HOSTNAME=$HOST

# Setup pacman, install packages, clean cache
RUN pacman -Syyu --noconfirm \
    && pacman-key --init \
    && pacman -S --noconfirm \
        bash-language-server \
        curl \
        fakeroot \
        gcc \
        git \
        git-delta \
        helix \
        lsd \
        man-db \
        make \
        neofetch \
        nodejs \
        npm \
        openssh \
        python \
        python-pip \
        pyright \
        ruff-lsp \
        rustup \
        rust-analyzer \
        texlab \
        tree \
        unzip \
        wget \
        wl-clipboard \
        zellij \
        zsh \
        zsh-syntax-highlighting \
        zsh-autosuggestions \
    && pacman -Scc --noconfirm

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Get configs
COPY ./confs/home /root
COPY ./confs/.config /root/.config

# Rust
RUN rustup default stable

# npm installs and cache
RUN npm install -g \
    typescript \
    typescript-language-server \
    npm-check-updates \
    vscode-langservers-extracted \
    && npm cache clean -f

# poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR /root/work


CMD [ "/bin/zsh" ]
