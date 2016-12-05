Dev Environment Configuration Files
===================================

Configuration files for my dev environment.

Setup
-----

### Install and configure Zsh

Follow steps on https://github.com/antiagainst/prezto.

### Install packages

#### Common

```bash
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

#### Ubuntu

```bash
sudo apt install tmux zsh vim python-pip git cmake ninja-build clang
sudo pip install --upgrade powerline-status

# fasd
sudo add-apt-repository ppa:aacebedo/fasd
sudo apt update
sudo apt install fasd
```

#### macOS

```bash
brew install fasd
```

### Checkout and link dotfiles

```bash
cd && git clone git@github.com:antiagainst/dotfiles.git .dotfiles
cd .dotfiles && ./install.sh
```

### Vim

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --racer-completer
```
