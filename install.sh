#!/bin/bash

ln -sf $(pwd)/dircolors         $HOME/.dircolors
ln -sf $(pwd)/gitconfig         $HOME/.gitconfig
ln -sf $(pwd)/hgrc              $HOME/.hgrc
ln -sf $(pwd)/tmux.conf         $HOME/.tmux.conf
ln -sf $(pwd)/vimrc             $HOME/.vimrc
ln -sf $(pwd)/ycm_extra_conf.py $HOME/.ycm_extra_conf.py

[ -d $HOME/.grc ] && rm -rf $HOME/.grc
ln -sf $(pwd)/grc           $HOME/.grc
[ ! -d $HOME/.config/nvim ] && mkdir -p $HOME/.config/nvim
ln -sf $(pwd)/vimrc                     $HOME/.config/nvim/init.vim

[ ! -d $HOME/.config/powerline/themes/tmux ] && mkdir -p $HOME/.config/powerline/themes/tmux
ln -sf $(pwd)/config/powerline/themes/tmux/default.json  $HOME/.config/powerline/themes/tmux/default.json

os=$(uname -s)

fail() {
  printf "%025s\n" "[failed]" "$@"
  exit 1
}

if [ "$os" == "Linux" ]; then
  [ ! -d $HOME/.fonts ] && mkdir $HOME/.fonts
  cp $(pwd)/fonts/PowerlineSymbols.otf $HOME/.fonts/

  release=$(lsb_release -i | cut -f2)
  if [ "$release" == "Ubuntu" ]; then
    ln -sf $(pwd)/tmux-ubuntu.conf  $HOME/.tmux-ubuntu.conf
    [ ! -d $HOME/.config/fontconfig/fonts.conf ] &&  mkdir -p $HOME/.config/fontconfig/fonts.conf
    ln -sf $(pwd)/config/fontconfig/10-powerline-symbols.conf $HOME/.config/fontconfig/fonts.conf/10-powerline-symbols.conf

    powerline_dir=$(pip show powerline-status | grep Location | cut -d\  -f2)
    [ -z "$powerline_dir" ] && fail "powerline-status not installed"
    rm -rf $HOME/.tmux-ubuntu.conf && cp $(pwd)/tmux-ubuntu.conf $HOME/.tmux-ubuntu.conf
    echo "source $powerline_dir/powerline/bindings/tmux/powerline.conf" >> $HOME/.tmux-ubuntu.conf
    echo "source $powerline_dir/powerline/bindings/tmux/powerline_tmux_2.1_plus.conf" >> $HOME/.tmux-ubuntu.conf
  elif [ "$release" != "Arch" ]; then
    fail "linux release not supported:" $release
  fi
elif [ "$os" == "Darwin" ]; then
  brew_root_dir=$(brew --env | grep CMAKE_PREFIX_PATH | cut -d\" -f2)
  powerline_dir=lib/python2.7/site-packages/powerline/bindings/tmux
  rm -rf $HOME/.tmux-osx.conf && cp $(pwd)/tmux-osx.conf $HOME/.tmux-osx.conf
  echo "source $brew_root_dir/$powerline_dir/powerline.conf" >> $HOME/.tmux-osx.conf
  echo "source $brew_root_dir/$powerline_dir/powerline_tmux_2.1_plus.conf" >> $HOME/.tmux-osx.conf
else
  fail "operating system not supported:" $os
fi
