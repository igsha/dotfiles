# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

export GIT_PS1_SHOWDIRTYSTATE=1
GIT_PROMPT_FILE=$HOME/.git-prompt.sh
if [[ -f $GIT_PROMPT_FILE ]]; then
    source $GIT_PROMPT_FILE
fi

__prompt_command() {
    local last_error="$?"

    local ColRst="\\[\\e[0m\\]";
    local Red="\\[\\e[01;31m\\]";
    local BRed="\\[\\e[1;31m\\]";
    local Gre="\\[\\e[01;32m\\]";
    local BBlu="\\[\\e[01;34m\\]";
    local Yell="\\[\\e[1;33m\\]";
    local FancyX="\\342\\234\\227";

    if [[ "x$savedPS1" == "x" ]]; then
        savedPS1=$PS1
    fi

    cleanSavedPS1=`echo "$savedPS1" | \
        sed \
            -e 's/\\\[\\033\[[[:digit:]]\+\(;[[:digit:]]\+\)\?m\\\]//g' \
            -e 's/\\\\[nrhuwsv\$]//g' \
            -e 's/\([][]\|[@:\$]\)//g' \
            -e 's/^[- ]\+//g' -e 's/[- ]\+$//g'`

    PS1="${Red}[\\A] ${Gre}\\u@\\h${BBlu} \\W"
    if [[ "x$(command -v __git_ps1)" != "x" ]]; then
        PS1+='$(__git_ps1)'
    fi

    local SIGN="${BBlu}\$";
    if [[ "x$cleanSavedPS1" != "x" ]]; then
        PS1+=" ${Yell}[$cleanSavedPS1]"
        SIGN="${Yell}%"
    fi

    if [[ $last_error != 0 ]]; then
        PS1+=" ${BRed}${FancyX} ($last_error)"
    fi

    PS1+=" $SIGN${ColRst} "
}
export PROMPT_COMMAND=__prompt_command
