# ~/.bashrc: executed by bash(1) for non-login shells.

# if not running interactively, don't do anything.
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it.
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# if set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1='[\u@\h \W]\$ '

# enable color support for manpage
export LESS_TERMCAP_mb=$(printf "\e[1;37m")
export LESS_TERMCAP_md=$(printf "\e[1;37m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;47;30m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[0;36m")

function env() {
  exec /usr/bin/env "$@" | grep -v ^LESS_TERMCAP_
}

# use Vim as man pager.
vman () {
  export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
                vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
	        -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
	        -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

  # invoke man page.
  man $1

  # we muse unset the PAGER, so regular man pager is used afterwards.
  unset PAGER
}

# enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases.
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# source-highlight-esc.h requires to install package source-highlight.
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS=' -R '

export VISUAL=vim
export EDITOR=vim

# ibus input method.
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export PATH=~/data/klee/install/bin:~/.local/bin:$PATH

if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi

# use tmux as default.
#[[ $TERM != "screen-256color" ]] && tmux && exit
[[ $TERM != "screen-256color" ]] && tmux
