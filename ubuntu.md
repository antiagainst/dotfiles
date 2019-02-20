Ubuntu Environment Setup
========================

### Generate SSH Key

```sh
ssh-keygen -t rsa -b 4096 -C "Ubuntu"
```

### Install essential tools

```sh
sudo apt install tmux zsh vim
sudo apt install cmake ninja-build clang
sudo apt install python-pip
sudo apt install rbenv
suto apt install xclip
sudo pip install --upgrade powerline-status

# fasd
sudo add-apt-repository ppa:aacebedo/fasd
sudo apt update
sudo apt install fasd

# ag & rg
sudo apt install silversearcher-ag
cargo install ripgrep

# fzf
gem install asciidoctor pygments.rb
git clone --depth 1 git@github.com:lotabout/skim.git ~/.skim
~/.skim/install
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
rbenv install -l
rbenv install <version>
rbenv global <version>
gem install bundler
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
./install.py --clang-completer --racer-completer
```
