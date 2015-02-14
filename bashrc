# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

function ifexists {
    if [[ "x$(command -v $1)" != "x" ]]; then
        $@
    fi
    return 0
}

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

BASH_COMPLETION_FILE=`echo /etc/profile.d/bash*completion.sh`
GIT_PROMPT_FILE=~/.git-prompt.sh
[[ -f $BASH_COMPLETION_FILE ]] && source $BASH_COMPLETION_FILE
[[ -f $GIT_PROMPT_FILE ]] && source $GIT_PROMPT_FILE

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\e[01;31m\][\A] \[\e[01;32m\]\u@\h\[\e[01;34m\] \W$(ifexists __git_ps1) \$\[\e[00m\] '
# Put your fun stuff here.
export PATH=$PATH:~/.gem/ruby/1.9.1/bin

export PATH_TO_ANT=/home/igor/qik/qiklib/ant
export ANT_HOME=$PATH_TO_ANT
export PATH=$ANT_HOME/bin:$PATH
export ANDROID_NDK=/opt/android-ndk

export MAKEOBJDIRPREFIX=~/.globaltags
export MATPLOTLIBRC=~/.config/matplotlib

export HISTCONTROL=ignoredups

alias ls="ls -h --color"
alias ls.pure="/bin/ls"
alias la="ls -lta"
alias ll="ls -lt"
alias grep="grep --color"
alias cal="cal -m3"
alias df="df -h"
alias truecrypt="truecrypt -t"
alias debian-chroot="sudo chroot ~/sandbox login builder"
alias wheezy-chroot="sudo chroot ~/wheezy login builder"
alias fake="PATH=/usr/sbin:/sbin:$PATH fakeroot fakechroot -s"
alias wineru="LC_ALL=ru_RU.UTF8 wine"
