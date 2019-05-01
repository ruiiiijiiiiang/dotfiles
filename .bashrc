# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\](\$(parse_git_branch))\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  if [[ ${EUID} == 0 ]] ; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
  fi
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
 . ~/.bash_aliases
fi

set -o vi
set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"

alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias lal='ls -al'
alias v='vim'
alias nv='nvim'
alias tm='tmux -2'
alias q='cd ..'
alias qq='cd ../..'
alias qqq='cd ../../..'
alias qqqq='cd ../../../..'
alias qqqqq='cd ../../../../..'
alias qqqqqq='cd ../../../../../..'
alias qqqqqqq='cd ../../../../../../..'
alias qqqqqqqq='cd ../../../../../../../..'
alias sdb='ssh belt.ooapi.com -L 27020:localhost:27017'
alias oodb='ssh vneck-21.ooapi.com -L 27069:localhost:27017'
alias sldb='ssh blazer-41.ooapi.com -L 27096:localhost:27017'
alias vimrc='vim ~/.vimrc'
alias nvimrc='nvim ~/.nvimrc'
alias bashrc='nvim ~/.bashrc'
alias tmuxrc='nvim ~/.tmux.conf'
alias e='dolphin . > /dev/null 2>&1 &'
alias pg='ping www.google.com'
alias vo='vim ~/oo'
alias bump='git pull --rebase; npm version patch; git push -u origin master --tags; npm publish'
alias np='pwdx `pgrep node`'
alias yloo='for module in `ls node_modules | grep oo-`; do yarn link $module; done'
alias ylsp='for module in `ls node_modules | grep sp-`; do yarn link $module; done'
alias ylsl='for module in `ls node_modules | grep sl-`; do yarn link $module; done'
alias yil='yarn --ignore-engines; yloo; ylsp; ylsl; rm yarn-error.log'
alias yolo='gulp dev-server'
alias swag='gulp main-server'
alias oovpn='sudo openvpn --config ~/Dropbox/rui.jiang.ovpn'
alias n='nodemon'

function run {
  ($1 $@ &> /dev/null &)
}

function cd {
  output=$(ls $@ 2>&1)
  if [[ $output != *"No such file or directory"* ]]; then
    builtin cd $@
    ls -ahl
  else
    echo $output
  fi
}

function findstr {
  grep -rnw . -e $@
}

function pullall {
  for repo in oo-config oo-components oo-crash oo-data oo-logger oo-middleware oo-queue-client oo-routes oo-util sp-components sp-dashboard-menu sp-designer sp-designer-util sp-manager-components sp-middleware sp-product-picker;
    do echo $repo && builtin cd ~/oo/$repo && git fetch && git checkout master && git pull
  done
  for repo in oo-artwork oo-billing oo-case oo-dashboard oo-dtg oo-email oo-employee oo-inventory oo-manager oo-mug oo-order oo-print oo-queue oo-racker oo-report oo-router oo-shipping oo-website sp-assembly sp-autoprint sp-dashboard sp-facility sp-manager sp-order sp-query sp-website;
    do echo $repo && builtin cd ~/oo/$repo && git fetch && git checkout develop && git pull
  done
}

function gitstat {
  git ls-files | grep -v '^yarn.lock$' | while read f; do git blame --line-porcelain $f | grep '^author '; done | sort -f | uniq -ic | sort -n
}

function sshooapi {
  ssh $@.ooapi.com
}

function sshfsooapi {
  if [ ! -d ~/ssh/$@ ]; then
    mkdir -p ~/ssh/$@
  fi
  sshfs -o allow_other $@.ooapi.com:/ ~/ssh/$@
}

export EDITOR=nvim
export LD_LIBRARY_PATH=/usr/lib:/usr/lib64:/usr/libx86_64-linux-gnu:/usr/local/lib:/usr/share/lib

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

eval $(thefuck --alias fuck)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)

echo '
          _______  _        _______
|\     /|(  ___  )( \      (  ___  )
( \   / )| (   ) || (      | (   ) |
 \ (_) / | |   | || |      | |   | |
  \   /  | |   | || |      | |   | |
   ) (   | |   | || |      | |   | |
   | |   | (___) || (____/\| (___) |
   \_/   (_______)(_______/(_______)
 _______           _______  _______
(  ____ \|\     /|(  ___  )(  ____ \
| (    \/| )   ( || (   ) || (    \/
| (_____ | | _ | || (___) || |
(_____  )| |( )| ||  ___  || | ____
      ) || || || || (   ) || | \_  )
/\____) || () () || )   ( || (___) |
\_______)(_______)|/     \|(_______)'
#source /opt/ros/kinetic/setup.bash
