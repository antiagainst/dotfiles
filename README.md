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
sudo apt install tmux zsh vim python-pip git cmake ninja-build clang xclip
sudo pip install --upgrade powerline-status

# fasd
sudo add-apt-repository ppa:aacebedo/fasd
sudo apt update
sudo apt install fasd
```

#### macOS

More about macOS set up:
https://gist.github.com/antiagainst/5b63c39960d875b5d75b.

```bash
brew install fasd reattach-to-user-namespace
```

### Checkout and link dotfiles

```bash
cd && git clone git@github.com:antiagainst/dotfiles.git .dotfiles
cd .dotfiles && ./install.sh
```

### Tmux

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
```

### Vim

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --racer-completer
```
