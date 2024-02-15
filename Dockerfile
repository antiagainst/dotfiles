FROM ubuntu:22.04

SHELL ["/bin/bash", "-e", "-u", "-o", "pipefail", "-c"]

# Disable apt-key parse waring
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Basic development environment
RUN apt-get update && apt-get install -y \
  curl wget \
  git zsh tmux vim neovim \
  build-essential cmake ninja-build \
  clang lld ccache \
  python3 python3-pip \
  pkg-config fasd

# Pyenv build dependencies
RUN DEBIAN_FRONTEND=noninteractive TZ=America/Los_Angeles apt-get install -y \
  libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev \
  libxml2-dev libxmlsec1-dev \
  libffi-dev liblzma-dev

# Tracy build dependencies
RUN apt-get install -y \
  libcapstone-dev libtbb-dev libzstd-dev \
  libglfw3-dev libfreetype6-dev libgtk-3-dev

# Development environment configuration files
RUN git clone https://github.com/antiagainst/dotfiles $HOME/.dotfiles && \
  git clone --recursive https://github.com/antiagainst/prezto $HOME/.zprezto
RUN for rcfile in $HOME/.zprezto/runcoms/*; do ln -s $rcfile $HOME/.`basename ${rcfile}`; done

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rust.sh
RUN bash rust.sh -y && rm -rf rust.sh
RUN $HOME/.cargo/bin/cargo install ripgrep lsd bat bottom broot skim cargo-cache
RUN git clone --depth 1 https://github.com/lotabout/skim $HOME/.skim && $HOME/.skim/install

RUN curl https://pyenv.run > python.sh
RUN bash python.sh && rm -rf python.sh

# Vim plugins
RUN git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim && \
  git clone https://github.com/ycm-core/YouCompleteMe.git $HOME/.vim/bundle/YouCompleteMe && \
  cd $HOME/.vim/bundle/YouCompleteMe && \
  git submodule update --init --recursive

RUN apt-get clean && rm -rf /var/lib/apt/lists/* && $HOME/.cargo/bin/cargo cache -a

WORKDIR /root
ENTRYPOINT /bin/zsh
