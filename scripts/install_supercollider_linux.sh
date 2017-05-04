#!/bin/bash

# install SuperCollider 3.8 and sc3-plugins. This will dump the source files in your home directory

mkdir ~/src 

cd ~/src

sudo apt-get install git

git clone --recursive -b 3.8 https://github.com/supercollider/supercollider.git

cd supercollider

# install dependencies
sudo apt-get install build-essential libjack-jackd2-dev libsndfile1-dev libasound2-dev libavahi-client-dev libicu-dev libreadline6-dev libfftw3-dev libxt-dev libudev-dev pkg-config git cmake qt5-default qt5-qmake qttools5-dev qttools5-dev-tools qtdeclarative5-dev libqt5webkit5-dev qtpositioning5-dev libqt5sensors5-dev libqt5opengl5-dev vim emacs jackd2

mkdir build

cd build

# cmake files
cmake -DCMAKE_PREFIX_PATH=/usr/lib/x86_64-linux-gnu/qt5/bin -DCMAKE_BUILD_TYPE=Release ..

make

# install supercollider
sudo make install

sudo ldconfig

# return to home directory

cd ~/src

# install sc3-plugins

git clone --recursive https://github.com/supercollider/sc3-plugins.git

cd sc3-plugins

mkdir build

cd build

cmake -DSC_PATH=/usr/local/include/SuperCollider ..

make

sudo make install

# return to home directory

cd ~/src
