FROM docker.io/library/archlinux:latest

# env
ENV TZ=Europe/Helsinki
ENV HOST=dev
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
        # python-lsp-server \
        rustup \
        rust-analyzer \
        texlab \
        tree \
        unzip \
        wget \
        zellij \
        zsh \
        zsh-syntax-highlighting \
        zsh-autosuggestions \
    && pacman -Scc --noconfirm

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Get configs
COPY ./confs /confs
RUN mkdir -p ~/.config

# Symlink everything
RUN ln -s /confs/helix ~/.config/ \
    && ln -s /confs/zellij ~/.config/ \
    && ln -s /confs/lsd ~/.config/ \
    && ln -s /confs/zsh/.zshrc ~/.zshrc && chsh -s /bin/zsh \
    && ln -s /confs/starship/starship.toml ~/.config/starship.toml \
    && ln -s /confs/pypoetry ~/.config/ \
    && ln -s /confs/git/.gitconfig ~/.gitconfig

# Rust
RUN rustup toolchain install nightly

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
