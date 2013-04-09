dotvim
======

My vim config with submodules. To use this vim config do:

cd ~
git clone http://github.com/username/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodule init
git submodule update


To update submodules:

git submodule foreach git pull origin master
