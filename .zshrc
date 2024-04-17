export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export DB_LOGGING=true

setopt -o sharehistory
set -o shwordsplit

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

alias l='lsd'
alias la='lsd -a'
alias ll='lsd -l'
alias lla='lsd -la'
alias lal='lsd -al'
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
alias oovpndal='sudo openvpn --config ~/Dropbox/rui.jiang-dallas.ovpn'
alias oovpnind='sudo openvpn --config ~/Dropbox/rui.jiang-indy.ovpn'
alias localtsc='./node_modules/typescript/bin/tsc'
alias rmmg='rm -rf ./node_modules/@types/mongoose/'
alias udn='cd node_modules/gulp && yarn add natives@1.1.6'

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

function cat {
  bat $@
}

function cloneoo {
  repos="oo-auth
  oo-auth-roles
  oo-boat
  oo-components
  oo-config
  oo-crash
  oo-data
  oo-email-client
  oo-logger
  oo-middleware
  oo-queue-client
  oo-routes
  oo-util
  sp-auth-client
  sp-components
  sp-dashboard-menu
  sp-designer
  sp-designer-util
  sp-dhl
  sp-manager-components
  sp-middleware
  sp-mockup-client
  sp-product-picker
  sp-sla
  oo-artwork
  oo-billing
  oo-dashboard
  oo-dtg
  oo-email-server
  oo-email
  oo-employee
  oo-inventory
  oo-manager
  oo-order
  oo-pretreat3
  oo-print
  oo-queue
  oo-racker
  oo-report
  oo-router
  oo-shipping
  oo-status
  oo-website
  sp-assembly
  sp-auth-server
  sp-autobagger
  sp-autoprint
  sp-dashboard
  sp-domain
  sp-dtg-server
  sp-embr
  sp-embr-server
  sp-facility
  sp-feature-flag
  sp-graphql
  sp-manager
  sp-mockup-server
  sp-order
  sp-query
  sp-website"
  for repo in $repos
    do echo cloning for $repo && git clone git@bitbucket.org:ooapi/$repo.git -q >/dev/null
  done
}

function pulloo {
  oo_home="~/oo/"
  libraries="oo-auth
  oo-auth-roles
  oo-boat
  oo-components
  oo-config
  oo-crash
  oo-data
  oo-email-client
  oo-logger
  oo-middleware
  oo-queue-client
  oo-routes
  oo-util
  sp-auth-client
  sp-components
  sp-dashboard-menu
  sp-designer
  sp-designer-util
  sp-dhl
  sp-manager-components
  sp-middleware
  sp-mockup-client
  sp-product-picker
  sp-sla"
  services="oo-artwork
  oo-billing
  oo-dashboard
  oo-dtg
  oo-email-server
  oo-email
  oo-employee
  oo-inventory
  oo-manager
  oo-order
  oo-pretreat3
  oo-print
  oo-queue
  oo-racker
  oo-report
  oo-router
  oo-shipping
  oo-status
  oo-website
  sp-assembly
  sp-auth-server
  sp-autobagger
  sp-autoprint
  sp-dashboard
  sp-domain
  sp-dtg-server
  sp-embr
  sp-embr-server
  sp-facility
  sp-feature-flag
  sp-graphql
  sp-manager
  sp-mockup-server
  sp-order
  sp-query
  sp-website"
  for repo in $libraries
    do echo pulling for $repo && builtin cd $oo_home$repo && git fetch -q >/dev/null && git checkout master -q >/dev/null && git pull -q >/dev/null
  done
  for repo in $services
    do echo pulling for $repo && builtin cd $oo_home$repo && git fetch -q >/dev/null && git checkout master -q >/dev/null && git pull -q >/dev/null
  done
}

function gitstat {
  git ls-files | grep -v '^yarn.lock$' | while read f; do git blame --line-porcelain $f | grep '^author '; done | sort -f | uniq -ic | sort -n
}

function oossh {
  ssh $@.ooapi.com
}

function veggie {
  ssh veggie.ooapi.com
}

function oosshfs {
  if [ ! -d ~/ssh/$@ ]; then
    mkdir -p ~/ssh/$@
  fi
  sshfs -o allow_other $@.ooapi.com:/ ~/ssh/$@
}

function cd {
  output=$(z $@ 2>&1)
  if [[ $output != *"no match found"* ]]; then
    z $@
    lsd -ahl
  else
    echo $output
  fi
}
export EDITOR=nvim

set -o vi
set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"

eval "$(zoxide init zsh)"

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

eval $(thefuck --alias)
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
