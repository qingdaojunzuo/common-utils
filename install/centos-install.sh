#!/bin/bash

set -eo pipefail

yum install -y epel-release
yum install -y yum-utils

# vim 8 on centos7
yum-config-manager --add-repo \
  https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo
yum remove -y vim-minimal

yum groupinstall -y 'Development Tools'
yum install -y sudo nodejs vsftpd git golang clang python-devel.x86_64 \
  python34-devel.x86_64 cmake vim docker-1.12.6 npm python2-pip.noarch python34-pip.noarch \
  ctags cscope ssh

pip install --upgrade pip
pip install --upgrade virtualenv
pip install pika

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
npm install typescript
git submodule update --init --recursive
./install.py --clang-completer --gocode-completer --tern-completer
