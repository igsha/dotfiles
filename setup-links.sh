#!/usr/bin/env bash

DOTFILESDIR=$HOME/.dotfiles
USERHOME=$HOME

STANDALONE=(bashrc gdbinit git-prompt.sh nixpkgs Xdefaults pentadactylrc gnuplot wcalcrc)
IN_CONFIG=(vifm dunst)
IN_BIN=(translate calculator message-recorder pylab)
CONFIGDIRS=(i3 qutebrowser nvim mpv matplotlib)

mkdir -p $USERHOME/{bin,.vimplugged} ${IN_CONFIG[@]/#/$USERHOME/.config/}

for ll in ${STANDALONE[*]}; do
    ln -sT $DOTFILESDIR/$ll $USERHOME/.$ll
done

for ll in ${IN_BIN[*]}; do
    ln -s $DOTFILESDIR/$ll $USERHOME/bin/
done

for ll in ${IN_CONFIG[*]}; do
    ln -s $DOTFILESDIR/${ll}rc $USERHOME/.config/$ll
done

for ll in ${CONFIGDIRS[*]}; do
    ln -sT $DOTFILESDIR/$ll $USERHOME/.config/$ll
done
