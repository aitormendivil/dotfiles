#!/bin/bash

SOURCE=$(pwd)

INSTALL_DIR="/tmp/bootstrap"
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR


sudo apt update && \
	sudo apt upgrade

# DEPENDENCIES 
sudo apt update && \
	sudo apt install -y wget curl git vim mercurial stow net-tools ranger feh cmake libasound2-dev libpulse-dev libcurl4-openssl-dev libmpdclient-dev libiw-dev xcb-proto python-xcbgen libpam0g-dev libjpeg-turbo8-dev compton htop fonts-font-awesome fonts-inconsolata openvpn scrot lxappearance autoconf automake libgtk-3-dev lxappearance unzip arandr

# FONT system San francisco
#git clone https://github.com/supermarin/YosemiteSanFranciscoFont.git sanfran
#cd sanfran
#cp ./*.ttf ~/.fonts
#cd $INSTALL_DIR

# Iosevka
# https://github.com/be5invis/Iosevka/releases/download/v2.2.1/02-iosevka-term-2.2.1.zip
#wget https://github.com/be5invis/Iosevka/releases/download/v2.2.1/02-iosevka-term-2.2.1.zip
#unzip 02-iosevka-term-2.2.1.zip
#cd ttf 
#cp ./*.ttf ~/.fonts
#cd $INSTALL_DIR
#sudo fc-cache

# I3 GAPS 
echo "Installing i3-gaps window manager from source..."
# Source: https://gist.github.com/dabroder/813a941218bdb164fb4c178d464d5c23
sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-*-dev i3status suckless-tools rofi

# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# pin the lastest release version
git checkout 4.16.1

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
cd $INSTALL_DIR


# SPOTIFY
sudo snap install spotify


# MOCA ICONS 
sudo add-apt-repository -u ppa:snwh/ppa
sudo apt install -y moka-icon-theme faba-icon-theme faba-mono-icons


# ROFI
sudo apt install -y rofi


# COMPTON
sudo apt install -y compton


# I3lock
sudo apt-get install -y  i3lock


# I3 BETTER LOCKSCREEN - NOT WORKING on Ubuntu 16
mkdir -p ~/.local/bin
stow -vt ~/.local/bin betterlockscreen
# update cache
~/.local/bin/betterlockscreen -u ~/.dotfiles/images/wallpaper.jpg


# ARC FIREFOX THEME 
git clone https://github.com/horst3180/arc-firefox-theme && cd arc-firefox-theme
./autogen.sh --prefix=/usr
sudo make install
cd $INSTALL_DIR


# ARC Theme
# https://github.com/horst3180/Arc-theme
git clone https://github.com/horst3180/arc-theme --depth 1 && cd arc-theme
./autogen.sh --prefix=/usr
sudo make instaill
cd $INSTALL_DIR


# POLYBAR

## dependencies
sudo apt install -y cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev

wget https://github.com/jaagr/polybar/releases/download/3.3.1/polybar-3.3.1.tar && tar -xvf polybar-3.3.1.tar
cd polybar && ./build.sh --all-features -f -A
cd $INSTALL_DIR

#sudo apt install zsh
#sudo apt-get install powerline fonts-powerline
#git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
#cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc


# Termite, zsh and theme

sudo apt-get install -y libgtk2.0-dev
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y build-essential gnome-devel
sudo apt-get install -y git g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac intltool libpcre2-dev libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev libxml2-utils gperf

cd /tmp
git clone https://github.com/thestinger/vte-ng.git
echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
cd vte-ng
./autogen.sh
make && sudo make install
sudo make install
sudo ldconfig
sudo mkdir -p /lib/terminfo/x
sudo ln -s /usr/local/share/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60

cd /tmp
git clone --recursive https://github.com/thestinger/termite.git
cd termite && make

cd /tmp
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cd /tmp
git clone https://github.com/romainl/Apprentice.git
cd Apprentice/
cp colors/apprentice.vim ~/.vim/colors
cd $INSTALL_DIR

## DOT FILES 
cd $SOURCE
cp -r .fonts/* ~/.fonts/
cp -r .config/* ~/.config/
cp -r .screenlayout/* ~/
cp -r .Xresources ~/

# VIM 

sudo apt install -y vim

## vim vinegar 

mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://github.com/tpope/vim-vinegar.git
cd $INSTALL_DIR


# vim plug 
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
