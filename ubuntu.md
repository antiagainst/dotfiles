Ubuntu Environment Setup
========================

### Generate SSH Key

```sh
ssh-keygen -t rsa -b 4096 -C "Ubuntu"
```

### Install essential tools

```sh
sudo apt install tmux zsh vim neovim
sudo apt install cmake ninja-build clang
sudo apt install python3 python3-pip
sudo apt install rbenv
suto apt install xclip

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 38
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 30

sudo pip install --upgrade powerline-status

curl https://sh.rustup.rs -sSf | sh
cargo install ripgrep lsd

sudo apt install fasd
git clone --depth 1 git@github.com:lotabout/skim.git $HOME/.skim && $HOME/.skim/install
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

### Setup Pyenv

[Install dependencies for building Python](https://github.com/pyenv/pyenv/wiki#suggested-build-environment), then

```sh
 curl https://pyenv.run | bash
 pyenv install --list
 pyenv install <version>
 pyenv global <version>
```

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
```

### Theme configuration

* `sudo apt install adapta-gtk-theme`
* Install oranchelo-icon-theme
* Install Monaco Nerd Mono fonts
* `sudo apt install gnome-tweak-tool`
