Dev Environment Configuration Files
===================================

Configuration files for my dev environment.

Setup
-----

### (Ubuntu) Install packages

```bash
sudo apt install tmux zsh vim python-pip git cmake ninja-build clang
sudo pip install --upgrade powerline-status
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
