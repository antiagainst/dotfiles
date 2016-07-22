#!/bin/bash

ln -sf $(pwd)/dircolors         $HOME/.dircolors
ln -sf $(pwd)/gitconfig         $HOME/.gitconfig
ln -sf $(pwd)/hgrc              $HOME/.hgrc
ln -sf $(pwd)/tmux.conf         $HOME/.tmux.conf
ln -sf $(pwd)/vimrc             $HOME/.vimrc
ln -sf $(pwd)/ycm_extra_conf.py $HOME/.ycm_extra_conf.py

os=$(uname -s)

if [ "$os" == "Linux" ]; then
  mkdir $HOME/.fonts && cp $(pwd)/fonts/PowerlineSymbols.otf $HOME/.fonts/

  release=$(lsb_release -i | cut -f2)
  if [ "$release" == "Ubuntu" ]; then
    ln -sf $(pwd)/tmux-ubuntu.conf  $HOME/.tmux-ubuntu.conf
    ln -sf $(pwd)/config/fontconfig/10-powerline-symbols.conf $HOME/.config/fontconfig/fonts.conf/10-powerline-symbols.conf
  elif [ "$release" != "Arch" ]; then
    print "linux release not supported:" $release
    exit 1
  fi
elif [ "$os" == "Darwin" ]; then
  brew_root_dir=$(brew --env | grep CMAKE_PREFIX_PATH | cut -d\" -f2)
  powerline_dir=lib/python2.7/site-packages/powerline/bindings/tmux
  rm -rf $HOME/.tmux-osx.conf && cp $(pwd)/tmux-osx.conf $HOME/.tmux-osx.conf
  echo "source $brew_root_dir/$powerline_dir/powerline.conf" >> $HOME/.tmux-osx.conf
  echo "source $brew_root_dir/$powerline_dir/powerline_tmux_2.1_plus.conf" >> $HOME/.tmux-osx.conf
else
  print "operating system not supported:" $os
  exit 1
fi
