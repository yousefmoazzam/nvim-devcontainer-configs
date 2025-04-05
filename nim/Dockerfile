FROM nimlang/nim:2.2.0-regular

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y git ninja-build gettext cmake unzip curl g++ ripgrep fzf tmux && \
    apt-get clean

WORKDIR /home
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
RUN chown -R dev /home/dev/.config/nvim /home/dev/.tmux /home/dev/.tmux.conf

USER dev
WORKDIR /home/dev
RUN wget https://github.com/arnetheduck/nph/releases/download/v0.6.1/nph-linux_x64.tar.gz && \
    tar xf nph-linux_x64.tar.gz && \
    mkdir bin && \
    mv nph bin
ENV PATH /home/dev/bin:$PATH
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
