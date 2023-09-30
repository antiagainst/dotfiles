Ubuntu Environment Setup
========================

### Generate SSH Key

```sh
ssh-keygen -t ed25519 -C "Ubuntu"
```

### Clone configuration repo

```sh
cd
git clone git@github.com:antiagainst/dotfiles.git .dotfiles
git clone --recursive git@github.com:antiagainst/prezto.git .zprezto
```

### Setup Zsh configuration

```sh
# Launch Zsh
zsh

# Copying the Zsh configuration files
setopt EXTENDED_GLOB
for rcfile in $HOME/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "$HOME/.${rcfile:t}"
done

# Set Zsh as default shell
chsh -s /bin/zsh
```

### Install essential tools

```sh
sudo apt install tmux zsh vim neovim
sudo apt install git cmake ninja-build clang lld
sudo apt install python3 python3-pip
sudo apt install rbenv
suto apt install xclip

sudo apt install fasd

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install ripgrep lsd bat bottom broot skim
# And use the following command to also install sk-tmux
git clone --depth 1 git@github.com:lotabout/skim.git $HOME/.skim && $HOME/.skim/install

sudo apt install ccache
ccache --max-size=50G
```

### Set up Python

[Install dependencies for building Python](https://github.com/pyenv/pyenv/wiki#suggested-build-environment), then

```sh
curl https://pyenv.run | bash

# Build dynamic Python library for YouCompleteMe plugin 
export PYTHON_CONFIGURE_OPTS="--enable-shared"
# Install bz2 so we compile Python with support for it; needed for YouCompleteMe
sudo apt install libssl-dev liblzma-dev libbz2-dev

pyenv install --list
pyenv install <version>
pyenv global <version>

pip install --upgrade pip
pip install --upgrade powerline-status
```

### Setup tool configuration

```sh
cd $HOME/.dotfiles && ./install.sh
```

### Setup Ruby

```sh
git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
git clone https://github.com/tpope/rbenv-aliases.git $HOME/.rbenv/plugins/rbenv-aliases
git clone https://github.com/rbenv/rbenv-default-gems.git $HOME/.rbenv/plugins/rbenv-default-gems
rbenv install -l
rbenv install <version>
rbenv global <version>
gem install bundler
gem install colorls
rbenv alias --auto
```

(Reference: [Using rbenv on Ubuntu 18.04](https://makandracards.com/makandra/28149-using-rbenv-on-ubuntu-18-04))

### Setup Tmux

```sh
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
$HOME/.tmux/plugins/tpm/bin/install_plugins
```

### Setup Vim

```sh
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd $HOME/.vim/bundle/YouCompleteMe
python3 install.py --clangd-completer --rust-completer
pip install --upgrade pynvim # Needed for YCM in NeoVim
```

### Theme configuration

* `sudo add-apt-repository universe`
* `sudo apt install gnome-tweaks`
* `sudo apt install adapta-gtk-theme`
* Install oranchelo-icon-theme
* Install Monaco Nerd Mono fonts
