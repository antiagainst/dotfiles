macOS Environment Setup
=======================

### Generate SSH Key

```sh
ssh-keygen -t ed25519 -C "MacBook Pro"
```

### Install Homebrew

```sh
# Following https://brew.sh/ for updated instructions
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install essential tools

```sh
brew install tmux macvim neovim
brew install cmake ninja rtags
brew install htop bottom tree
brew install lsd fasd broot
brew install bash go pyenv rbenv
brew install bat git-delta
brew install wget exiftool

brew install ripgrep sk
# And use the following command to also install sk-tmux
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

### Setup Python

```sh
# Build dynamic Python library for YouCompleteMe plugin 
export PYTHON_CONFIGURE_OPTS="--enable-shared"

pyenv install -l
pyenv install <version>
pyenv global <version>
```

#### Setup Powerline


* Install powerline status

```sh
pip install --upgrade git+git://github.com/powerline/powerline
pip install --upgrade powerline-status
```

* Download and install patched font

```sh
# https://github.com/ryanoasis/nerd-fonts
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code-nerd-font
# Monaco Nerd Font from Google Drive
```


### Setup Ruby

```sh
rbenv install -l
rbenv install <version>
rbenv global <version>
gem install bundler
gem install colorls
```

### Setup tool configuration

```sh
cd $HOME/.dotfiles && ./install.sh
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
pip install --upgrade pynvim # Needed for YCM in NeoVim
```


### Setup iTerm2

Import colorschems from https://github.com/mbadolato/iTerm2-Color-Schemes
* Light theme: Mirage / DimmedMonokai / AdventureTime / Afterglow
* Dark theme: AtelierSulphurpool
