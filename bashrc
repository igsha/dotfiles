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

GIT_PROMPT_FILE=~/.git-prompt.sh
[[ -f $GIT_PROMPT_FILE ]] && source $GIT_PROMPT_FILE

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\e[01;31m\][\A] \[\e[01;32m\]\u@\h\[\e[01;34m\] \W$(ifexists __git_ps1) \$\[\e[00m\] '
# Put your fun stuff here.

export HISTCONTROL=ignoredups

alias ls="ls -h --color"
alias ls.pure="`which ls`"
alias la="ls -lta"
alias ll="ls -lt"
alias grep="grep --color"
alias cal="cal -m3"
alias df="df -h"
alias wineru="LC_ALL=ru_RU.UTF-8 wine"

unset SSH_ASKPASS

export EDITOR=nvim
export BROWSER=qutebrowser
export PDFVIEWER=zathura
export PSVIEWER=$PDFVIEWER
export DVIVIEWER=$PDFVIEWER
