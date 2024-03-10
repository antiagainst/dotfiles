FROM ubuntu:22.04

SHELL ["/bin/bash", "-e", "-u", "-o", "pipefail", "-c"]

# Disable apt-key parse waring
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Basic development environment
RUN apt-get update && apt-get install -y \
  software-properties-common \
  curl wget git zsh tmux \
  build-essential cmake ninja-build \
  clang lld ccache \
  python3 python3-pip \
  pkg-config fasd

RUN add-apt-repository -y ppa:neovim-ppa/stable && \
  apt-get update && apt-get install -y vim neovim vim-youcompleteme

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

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Zsh configuration files
RUN  git clone --recursive https://github.com/antiagainst/prezto $HOME/.zprezto
RUN for rcfile in $HOME/.zprezto/runcoms/*; do ln -s $rcfile $HOME/.`basename ${rcfile}`; done

# Rust developer toolchain and binaries
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rust.sh && \
  bash rust.sh -y && rm -rf rust.sh
RUN $HOME/.cargo/bin/cargo install ripgrep lsd bat bottom broot skim cargo-cache && \
  $HOME/.cargo/bin/cargo cache -a
RUN git clone --depth 1 https://github.com/lotabout/skim $HOME/.skim && $HOME/.skim/install

# Pyenv setup
ARG PYTHON_CONFIGURE_OPTS="--enable-shared"
RUN curl https://pyenv.run > python.sh && bash python.sh && rm -rf python.sh && \
  $HOME/.pyenv/bin/pyenv install 3.11.5 && $HOME/.pyenv/bin/pyenv global 3.11.5
RUN $HOME/.pyenv/shims/pip install --upgrade pip powerline-status

# Development environment configuration files
RUN git clone https://github.com/antiagainst/dotfiles $HOME/.dotfiles && \
  cd $HOME/.dotfiles && PIP_PATH=$HOME/.pyenv/shims/pip ./install.sh

# Vim plugins
RUN git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim && \
  $HOME/.pyenv/shims/pip install --upgrade pynvim
#RUN [ "/bin/bash", "-c", "vim -T dumb -n -i NONE -es -S <(echo -e 'silent! PluginInstall')" ]
#RUN ["/bin/bash", "-c", "vim.basic -E -s -u $HOME/.vimrc +PlugInstall +qall"]

# Ccache settings
ENV CCACHE_DIR=/ccahe
RUN ccache --max-size=50G

WORKDIR /root
ENTRYPOINT /bin/zsh
