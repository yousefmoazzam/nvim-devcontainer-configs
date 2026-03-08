FROM docker.io/archlinux:base-devel

RUN sudo pacman -Syu --noconfirm && \
    sudo pacman -S --noconfirm git neovim tmux wget && \
    sudo pacman -Scc --noconfirm

WORKDIR /home/dev

ARG C3_VERSION="0.7.10"
ENV C3_VERSION=$C3_VERSION
RUN wget https://github.com/c3lang/c3c/releases/download/v$C3_VERSION/c3-linux.tar.gz && \
    tar xf c3-linux.tar.gz && \
    rm c3-linux.tar.gz

ARG C3_LSP_VERSION="0.4.0"
ENV C3_LSP_VERSION=$C3_LSP_VERSION
RUN wget https://github.com/pherrymason/c3-lsp/releases/download/v$C3_LSP_VERSION/c3lsp-linux-amd64.tar.gz && \
    tar xf c3lsp-linux-amd64.tar.gz && \
    rm c3lsp-linux-amd64.tar.gz

WORKDIR /home/dev/bin
ARG C3_FMT_VERSION="0.2.2"
ENV C3_FMT_VERSION=$C3_FMT_VERSION
RUN wget https://github.com/lmichaudel/c3fmt/releases/download/v$C3_FMT_VERSION/c3fmt-linux && \
    mv c3fmt-linux c3fmt && \
    chmod +x c3fmt

ENV PATH="$PATH:/home/dev/c3:/home/dev/server/bin/release:/home/dev/bin"

WORKDIR /home

RUN useradd --create-home --shell /bin/bash dev

RUN git clone https://github.com/tmux-plugins/tpm /home/dev/.tmux/plugins/tpm
COPY ./config /home/dev/.config/nvim
COPY .tmux.conf /home/dev
COPY ./update-tmux-env.sh /etc/profile.d/
RUN chown -R dev /home/dev/

USER dev
# This is for installing neovim plugins from a shell using the Lazy package
# manager, rather than installing them once a container has been started from
# the built image. See:
# - https://vi.stackexchange.com/a/44013
# - https://github.com/folke/lazy.nvim/issues/1409
RUN nvim --headless "+Lazy! sync" +qa
# This is for installing tmux plugins from a shell (using the tpm plugin
# manager), rather than installing them once a container has been started from
# the built image, see
# https://github.com/tmux-plugins/tpm/issues/6#issuecomment-622178474
RUN ~/.tmux/plugins/tpm/bin/install_plugins
WORKDIR /home/dev
