FROM docker.io/library/archlinux:latest

# env
ENV TZ=Europe/Helsinki
# ENV HOST=kontti
# ENV HOSTNAME=$HOST

# Get configs
COPY ./pkgs/arch.txt /root/pkgs.txt
COPY ./confs/home /root
COPY ./confs/.config /root/.config

# Setup pacman, install packages, clean cache
RUN pacman -Syyu --noconfirm \
    && pacman-key --init \
    && pacman -S --noconfirm \
    $(cat /root/pkgs.txt) \
    && pacman -Scc --noconfirm

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Rust
# RUN rustup default stable

# npm installs and cache
RUN npm install -g \
    typescript \
    typescript-language-server \
    @astrojs/language-server \
    npm-check-updates \
    # vscode-langservers-extracted \
    && npm cache clean -f

# poetry
# RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR /root/work


CMD [ "/bin/zsh" ]
