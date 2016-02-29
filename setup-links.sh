#!/usr/bin/env bash

DOTFILESDIR=$HOME/.dotfiles
USERHOME=$HOME

for ll in bashrc gdbinit git-prompt.sh nixpkgs i3 Xdefaults xprofile pentadactylrc gnuplot; do
    ln -s $DOTFILESDIR/$ll $USERHOME/.$ll
done

mkdir -p $USERHOME/{bin,.vifm,.config/{matplotlib,zathura},.vimbundle}

git clone https://github.com/igsha/vim-settings.git $USERHOME/.vim
(cd $USERHOME/.vimbundle; git clone https://github.com/Shougo/neobundle.vim)

ln -s $DOTFILESDIR/calculator $USERHOME/bin/
ln -s $DOTFILESDIR/translate $USERHOME/bin/

ln -s $DOTFILESDIR/matplotlibrc $USERHOME/.config/matplotlib/
ln -s $DOTFILESDIR/zathurarc $USERHOME/.config/zathura/

ln -s $DOTFILESDIR/vifmrc $USERHOME/.vifm/

