#!/bin/bash
sudo apt-get install git xserver-xorg rxvt-unicode xdm feh xdg-utils

mkdir $HOME/opt
git clone git://git.savannah.gnu.org/emacs.git $HOME/opt/emacs.repo
git clone https://git@github.com/ch11ng/xelb.git $HOME/opt/xelb.repo
git clone https://git@github.com/ch11ng/exwm.git $HOME/opt/exwm.repo
sudo apt-get build-dep emacs
sudo apt-get install libgtk-3-dev libjpeg-dev libtiff5-dev libxpm-dev libgif-dev libpng-dev libncurses5-dev libmailutils-dev mailutils
(cd $HOME/opt/emacs.repo && ./autogen.sh && make && make install)

ln -snf $HOME/config/emacs/dot_emacs $HOME/.emacs
ln -snf $HOME/config/emacs/dot_dir_locals.el $HOME/.dir-locals.el
ln -snf $HOME/config/fonts $HOME/.fonts
ln -snf $HOME/xsession/dot_xsession $HOME/.xsession
