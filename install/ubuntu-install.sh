#!/bin/bash

set -eo pipefail

apt-get install -y nodejs vsftpd git golang clang python-dev \
  python3-dev build-essential cmake vim docker.io npm python-pip \
  ctags cscope ssh

ln -s /usr/bin/nodejs /usr/bin/node

pip install --upgrade pip
pip install --upgrade virtualenv
pip install pika

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
npm install typescript
git submodule update --init --recursive
./install.py --clang-completer --gocode-completer --tern-completer
