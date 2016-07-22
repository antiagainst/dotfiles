.PHONY: install

cwd = $(shell pwd)

install:
	ln -sf $(cwd)/dircolors         $(HOME)/.dircolors
	ln -sf $(cwd)/gitconfig         $(HOME)/.gitconfig
	ln -sf $(cwd)/hgrc              $(HOME)/.hgrc
	ln -sf $(cwd)/tmux-ubuntu.conf  $(HOME)/.tmux-ubuntu.conf
	ln -sf $(cwd)/tmux-osx.conf     $(HOME)/.tmux-osx.conf
	ln -sf $(cwd)/tmux.conf         $(HOME)/.tmux.conf
	ln -sf $(cwd)/vimrc             $(HOME)/.vimrc
	ln -sf $(cwd)/ycm_extra_conf.py $(HOME)/.ycm_extra_conf.py
