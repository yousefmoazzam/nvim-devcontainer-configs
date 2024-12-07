FROM debian:bullseye-20241202-slim

RUN apt-get update -y && \
    apt-get install -y git ninja-build gettext cmake unzip curl g++ ripgrep fzf tmux wget xz-utils && \
    apt-get clean

WORKDIR /home/dev

ARG ZIG_VERSION="0.13.0"
ENV ZIG_VERSION=$ZIG_VERSION
RUN wget https://ziglang.org/download/$ZIG_VERSION/zig-linux-x86_64-$ZIG_VERSION.tar.xz && \
    tar xvf zig-linux-x86_64-$ZIG_VERSION.tar.xz && \
    rm zig-linux-x86_64-$ZIG_VERSION.tar.xz

ENV PATH="$PATH:/home/dev/zig-linux-x86_64-$ZIG_VERSION"

RUN git clone https://github.com/neovim/neovim
WORKDIR neovim
RUN git checkout stable && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install

WORKDIR /home
#RUN rm -rf ./neovim

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
