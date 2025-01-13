FROM node:lts-bullseye-slim

RUN apt-get update -y && \
    apt-get install -y git ninja-build gettext cmake unzip curl g++ ripgrep fzf tmux pkg-config && \
    apt-get clean

WORKDIR /home
RUN git clone https://github.com/neovim/neovim
WORKDIR neovim
RUN git checkout stable && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install

WORKDIR /home
#RUN rm -rf ./neovim

RUN git clone https://github.com/tmux-plugins/tpm /home/node/.tmux/plugins/tpm
COPY ./config /home/node/.config/nvim
COPY .tmux.conf /home/node
COPY ./update-tmux-env.sh /etc/profile.d/
RUN chown -R node /home/node/.config/nvim /home/node/.tmux /home/node/.tmux.conf

RUN npm install -g svelte-language-server
RUN npm install -g eslint eslint-plugin-svelte
RUN npm install -g prettier
RUN npm install -g prettier-plugin-svelte
RUN npm install -g typescript-language-server

USER node
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

WORKDIR /home/node

ENTRYPOINT ["/bin/bash"]
