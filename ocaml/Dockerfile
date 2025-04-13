FROM debian:stable-20250407-slim AS build

USER root

RUN apt-get update -y && \
    apt-get install -y git ninja-build gettext cmake unzip curl g++ pkg-config

WORKDIR /home
RUN git clone https://github.com/neovim/neovim
WORKDIR neovim
RUN git checkout stable && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install

FROM ocaml/opam:ubuntu-24.04-ocaml-5.3 AS dev

COPY --from=build /usr/local/bin/nvim /usr/local/bin

USER root

RUN apt-get update -y && \
    apt-get install -y git ripgrep fzf tmux && \
    apt-get clean

USER opam

RUN git clone https://github.com/tmux-plugins/tpm /home/opam/.tmux/plugins/tpm
COPY ./config /home/opam/.config/nvim
COPY .tmux.conf /home/opam
COPY ./update-tmux-env.sh /etc/profile.d/

RUN opam install ocaml-lsp-server
RUN opam install ocamlformat
RUN opam install utop

COPY --from=build /usr/local/share/nvim /usr/local/share/nvim

USER root
RUN chown -R opam /home/opam/.config/nvim /home/opam/.tmux /home/opam/.tmux.conf
USER opam
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

WORKDIR /home/opam
