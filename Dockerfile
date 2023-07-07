FROM docker.io/library/archlinux:latest

# Setup pacman, install packages, clean cache
RUN pacman -Syyu --noconfirm \
    && pacman-key --init \
    && pacman -S --noconfirm \
        biber \
        curl \
        gcc \
        git \
        git-delta \
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

# Set timezone
ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Get configs
RUN git clone --depth=1 https://github.com/eemilhaa/kontti /dotfiles \
    && mkdir -p ~/.config

# Symlink everything
RUN ln -s /dotfiles/confs/helix ~/.config/ \
    && ln -s /dotfiles/confs/zellij ~/.config/ \
    && ln -s /dotfiles/confs/lsd ~/.config/ \
    && ln -s /dotfiles/confs/zsh/.zshrc ~/.zshrc && chsh -s /bin/zsh \
    && ln -s /dotfiles/confs/starship/starship.toml ~/.config/starship.toml \
    && ln -s /dotfiles/confs/pypoetry ~/.config/ \
    && ln -s /dotfiles/confs/git/.gitconfig ~/.gitconfig

# npm installs and cache
RUN npm install -g typescript typescript-language-server \
    && npm cache clean -f

# poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR /root/work

CMD [ "/bin/zsh" ]
