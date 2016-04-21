#!/usr/bin/env bash

DOTFILESDIR=$HOME/.dotfiles
USERHOME=$HOME

STANDALONE=(bashrc gdbinit git-prompt.sh nixpkgs Xdefaults xprofile pentadactylrc gnuplot wcalcrc)
IN_CONFIG=(vifm matplotlib zathura dunst)
IN_BIN=(translate calculator)
CONFIGDIRS=(i3 qutebrowser nvim)

mkdir -p $USERHOME/{bin,.vimbundle} ${IN_CONFIG[@]/#/$USERHOME/.config/}

for ll in ${STANDALONE[*]}; do
    ln -s $DOTFILESDIR/$ll $USERHOME/.$ll
done

for ll in ${IN_BIN[*]}; do
    ln -s $DOTFILESDIR/$ll $USERHOME/bin/
done

for ll in ${IN_CONFIG[*]}; do
    ln -s $DOTFILESDIR/${ll}rc $USERHOME/.config/$ll
done

for ll in ${CONFIGDIRS[*]}; do
    ln -s $DOTFILESDIR/$ll $USERHOME/.config/
done

git clone https://github.com/igsha/vim-settings.git $USERHOME/.vim
(cd $USERHOME/.vimbundle; git clone https://github.com/Shougo/neobundle.vim)

