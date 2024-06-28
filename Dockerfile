# Build: sudo docker build . -t dev-env --build-arg DOCKER_USERID=$(id -u) --build-arg DOCKER_GROUPID=$(id -g) --build-arg DOCKER_RENDERID=$(getent group render | cut -d: -f3)
FROM antiagainst/triton-hip:ubuntu22.04-python3.10-rocm6.4

SHELL ["/bin/bash", "-e", "-u", "-o", "pipefail", "-c"]

# Disable apt-key parse waring
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Basic development environment
RUN apt-get update && apt-get install -y \
  software-properties-common \
  curl wget openssh-client git zsh tmux less \
  build-essential cmake ninja-build \
  clang lld ccache \
  python3 python3-pip \
  pkg-config fasd \
  numactl

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

# Create non-root user account to mirror host user account
ARG DOCKER_USERID=0
ARG DOCKER_GROUPID=0
ARG DOCKER_USERNAME=mirror
ARG DOCKER_GROUPNAME=mirror

RUN if [ ${DOCKER_USERID} -ne 0 ] && [ ${DOCKER_GROUPID} -ne 0 ]; then \
    groupadd --gid ${DOCKER_GROUPID} ${DOCKER_GROUPNAME} && \
    useradd --no-log-init --create-home \
      --uid ${DOCKER_USERID} --gid ${DOCKER_GROUPID} \
      --shell /usr/bin/zsh ${DOCKER_USERNAME}; \
fi

# Create render group needed for AMD GPU access
ARG DOCKER_RENDERID=0

RUN if [ ${DOCKER_USERID} -ne 0 ] && [ ${DOCKER_RENDERID} -ne 0 ]; then \
    groupadd --gid ${DOCKER_RENDERID} render && \
    usermod -aG render ${DOCKER_USERNAME} && \
    usermod -aG video ${DOCKER_USERNAME}; \
fi

# Ccache settings
ENV CCACHE_DIR=/ccache
RUN ccache --max-size=15G

# Create mapping directories and chown before switching user
RUN mkdir -p /ccache && chown ${DOCKER_USERID}:${DOCKER_GROUPID} /ccache && \
  mkdir -p /data && chown ${DOCKER_USERID}:${DOCKER_GROUPID} /data

# Now switch to the mirror user and setup configurations
USER ${DOCKER_USERNAME}
WORKDIR /home/${DOCKER_USERNAME}

# Zsh configuration files
RUN  git clone --depth 1 --recursive https://github.com/antiagainst/prezto $HOME/.zprezto
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
RUN git clone --depth 1 https://github.com/antiagainst/dotfiles $HOME/.dotfiles && \
  cd $HOME/.dotfiles && PIP_PATH=$HOME/.pyenv/shims/pip ./install.sh

# Vim plugins
# It would be nice to directly install all plugins using Vundle. But didn't
# find a working solution. So, just explicitly clone all interesting ones.
#RUN [ "/bin/bash", "-c", "vim -T dumb -n -i NONE -es -S <(echo -e 'silent! PluginInstall')" ]
#RUN ["/bin/bash", "-c", "vim.basic -E -s -u $HOME/.vimrc +PlugInstall +qall"]
RUN git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim && \
  git clone --depth 1 https://github.com/flazz/vim-colorschemes.git $HOME/.vim/bundle/vim-colorschemes && \
  git clone --depth 1 https://github.com/kien/rainbow_parentheses.vim.git $HOME/.vim/bundle/rainbow_parentheses.vim && \
  git clone --depth 1 https://github.com/vim-airline/vim-airline.git $HOME/.vim/bundle/vim-airline && \
  git clone --depth 1 https://github.com/vim-airline/vim-airline-themes.git $HOME/.vim/bundle/vim-airline-themes && \
  git clone --depth 1 https://github.com/Lokaltog/vim-easymotion.git $HOME/.vim/bundle/vim-easymotion && \
  git clone --depth 1 https://github.com/tpope/vim-repeat.git $HOME/.vim/bundle/vim-repeat && \
  git clone --depth 1 https://github.com/adelarsq/vim-matchit.git $HOME/.vim/bundle/vim-matchit && \
  git clone --depth 1 https://github.com/tpope/vim-surround.git $HOME/.vim/bundle/vim-surround && \
  git clone --depth 1 https://github.com/terryma/vim-multiple-cursors.git $HOME/.vim/bundle/vim-multiple-cursors && \
  git clone --depth 1 https://github.com/michaeljsmith/vim-indent-object.git $HOME/.vim/bundle/vim-indent-object && \
  git clone --depth 1 https://github.com/wellle/targets.vim.git $HOME/.vim/bundle/targets.vim && \
  git clone --depth 1 https://github.com/lotabout/skim.vim.git $HOME/.vim/bundle/skim.vim && \
  git clone --depth 1 https://github.com/jremmen/vim-ripgrep.git $HOME/.vim/bundle/vim-ripgrep && \
  git clone --depth 1 https://github.com/dyng/ctrlsf.vim.git $HOME/.vim/bundle/ctrlsf.vim && \
  git clone --depth 1 https://github.com/benmills/vimux.git $HOME/.vim/bundle/vimux && \
  git clone --depth 1 https://github.com/tpope/vim-eunuch.git $HOME/.vim/bundle/vim-eunuch && \
  git clone --depth 1 https://github.com/tpope/vim-fugitive.git $HOME/.vim/bundle/vim-fugitive && \
  git clone --depth 1 https://github.com/google/vim-maktaba.git $HOME/.vim/bundle/vim-maktaba && \
  git clone --depth 1 https://github.com/google/vim-glaive.git $HOME/.vim/bundle/vim-glaive && \
  git clone --depth 1 https://github.com/google/vim-syncopate.git $HOME/.vim/bundle/vim-syncopate && \
  git clone --depth 1 https://github.com/Valloric/YouCompleteMe.git $HOME/.vim/bundle/YouCompleteMe && \
  git clone --depth 1 https://github.com/antiagainst/vim-rtags.git $HOME/.vim/bundle/vim-rtags && \
  git clone --depth 1 https://github.com/tomtom/tcomment_vim.git $HOME/.vim/bundle/tcomment_vim && \
  git clone --depth 1 https://github.com/nathanaelkane/vim-indent-guides.git $HOME/.vim/bundle/vim-indent-guides && \
  git clone --depth 1 https://github.com/kana/vim-operator-user.git $HOME/.vim/bundle/vim-operator-user && \
  git clone --depth 1 https://github.com/rhysd/vim-clang-format.git $HOME/.vim/bundle/vim-clang-format && \
  git clone --depth 1 https://github.com/vim-scripts/DrawIt.git $HOME/.vim/bundle/DrawIt && \
  git clone --depth 1 https://github.com/vim-scripts/a.vim.git $HOME/.vim/bundle/a.vim && \
  git clone --depth 1 https://github.com/klen/python-mode.git $HOME/.vim/bundle/python-mode && \
  git clone --depth 1 https://github.com/fatih/vim-go.git $HOME/.vim/bundle/vim-go && \
  git clone --depth 1 https://github.com/rust-lang/rust.vim.git $HOME/.vim/bundle/rust.vim && \
  git clone --depth 1 https://github.com/plasticboy/vim-markdown.git $HOME/.vim/bundle/vim-markdown && \
  git clone --depth 1 https://github.com/tikhomirov/vim-glsl.git $HOME/.vim/bundle/vim-glsl && \
  git clone --depth 1 https://github.com/jcf/vim-latex.git $HOME/.vim/bundle/vim-latex && \
  git clone --depth 1 https://github.com/kbenzie/vim-spirv.git $HOME/.vim/bundle/vim-spirv && \
  git clone --depth 1 https://github.com/antiagainst/vim-tablegen.git $HOME/.vim/bundle/vim-tablegen && \
  git clone --depth 1 https://github.com/scrooloose/nerdtree.git $HOME/.vim/bundle/nerdtree && \
  git clone --depth 1 https://github.com/fholgado/minibufexpl.vim.git $HOME/.vim/bundle/minibufexpl.vim && \
  git clone --depth 1 https://github.com/majutsushi/tagbar.git $HOME/.vim/bundle/tagbar && \
  git clone --depth 1 https://github.com/regedarek/ZoomWin.git $HOME/.vim/bundle/ZoomWin

RUN cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && \
  $HOME/.pyenv/shims/python ./install.py --clangd-completer

RUN $HOME/.pyenv/shims/pip install --upgrade pip pynvim "setuptools>=40.8.0" wheel \
  "cmake>=3.18,<4.0" "ninja>=1.11.1" "pybind11>=2.13.1" nanobind lit \
  numpy scipy pandas matplotlib pytest pytest-xdist pylama pre-commit

WORKDIR /data
ENTRYPOINT /usr/bin/zsh
