FROM ubuntu:24.04

RUN apt-get update -y && \
    apt-get install -y git ninja-build gettext cmake unzip curl clang ripgrep fzf tmux pkg-config libssl-dev && \
    apt-get clean

WORKDIR /home/ubuntu

RUN git clone https://github.com/neovim/neovim
WORKDIR neovim
RUN git checkout stable && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install

WORKDIR /home

RUN git clone https://github.com/tmux-plugins/tpm /home/ubuntu/.tmux/plugins/tpm
COPY ./config /home/ubuntu/.config/nvim
COPY .tmux.conf /home/ubuntu
COPY ./update-tmux-env.sh /etc/profile.d/
RUN chown -R ubuntu /home/ubuntu/

RUN apt-get install -y clangd-18 clang-format && apt-get clean

USER ubuntu
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
WORKDIR /home/ubuntu
