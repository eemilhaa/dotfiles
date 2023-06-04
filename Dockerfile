FROM docker.io/library/archlinux:latest

# Setup pacman, install packages, clean cache
RUN pacman -Syyu --noconfirm \
    && pacman-key --init \
    && pacman -S --noconfirm \
        biber \
        curl \
        gcc \
        git \
        helix \
        lsd \
        make \
        neofetch \
        nodejs \
        npm \
        openssh \
        python \
        python-pip \
        # pyright \
        python-lsp-server \
        starship \
        texlab \
        texlive \
        texlive-bibtexextra \
        tree \
        unzip \
        wget \
        zellij \
        zsh \
        zsh-syntax-highlighting \
    && pacman -Scc --noconfirm

# Get configs
RUN git clone --depth=1 https://github.com/eemilhaa/kontti /dotfiles \
    && mkdir -p ~/.config

# Symlink everything
RUN ln -s /dotfiles/confs/helix ~/.config/ \
    && ln -s /dotfiles/confs/zellij ~/.config/ \
    && ln -s /dotfiles/confs/lsd ~/.config/ \
    && ln -s /dotfiles/confs/zsh/.zshrc ~/.zshrc && chsh -s /bin/zsh \
    && ln -s /dotfiles/confs/starship/starship.toml ~/.config/starship.toml \
    && ln -s /dotfiles/confs/pypoetry ~/.config/

# npm installs and cache
RUN npm install -g typescript typescript-language-server \
    && npm cache clean -f

# poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# git
RUN git config --global user.name "eemilhaa" \
    && git config --global user.email "eemil.haapanen@gmail.com" \
    && git config --global --add safe.directory /root/work

WORKDIR /root/work

CMD [ "/bin/zsh" ]
