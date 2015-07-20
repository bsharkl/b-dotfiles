#!/bin/bash
# ====================================================
#   Copyright (C)2015 All rights reserved.
#
#   Author  : bbxytl
#   Email   : bbxytl@gmail.com
#   FileName: run.sh
#   LastModify : 2015-07-20 14:45
#   Describe:
#
#   Log     :
#
# ====================================================

# 安装环境

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

echo " 安装环境，过程中需要输入密码。。。。。请输入："
read PASSWD

echo $PASSWD | sudo -S yum install -y python-devel.x86_64
sudo yum groupinstall 'Development Tools'
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
echo $PASSWD | sudo -S yum install -y  the_silver_searcher


echo " wget install......"
echo $PASSWD | sudo -S yum install -y  wget
echo " pip install......."
rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
echo $PASSWD | sudo -S yum install -y  epel-release
echo $PASSWD | sudo -S yum install -y  python-pip
echo " tmux env install........"
echo $PASSWD | sudo -S yum install -y  ncurses-devel
echo $PASSWD | sudo -S yum install -y  autoconf m4 perl automake
sudo autoconf -ivf

echo $PASSWD | sudo -S  pip install pyflakes
echo $PASSWD | sudo -S  pip install pylint
echo $PASSWD | sudo -S  pip install pep8
pep8str="[pep8]\nmax-line-length = 120"
if [ ! -e $HOME/.config ]; then mkdir $HOME/.config; fi
if [ ! -e $HOME/.config/pep8 ];then
	echo -e pep8str > $HOME/.config/pep8
fi

# 一：安装 CMake 命令
if [ ! -e $HOME/tmp ];then mkdir $HOME/tmp ; fi
cd $HOME/tmp
wget http://www.cmake.org/files/v3.2/cmake-3.2.3.tar.gz
tar -zxvf cmake-3.2.3.tar.gz
cd cmake-3.2.3
./bootstrap
make && echo $PASSWD | sudo -S make install
cd $CURRENT_DIR

# 配置 shell
echo $PASSWD | sudo -S chmod +x $CURRENT_DIR/b-shell/install-shell.sh
cd $CURRENT_DIR/b-shell
./install-shell.sh $PASSWD

# 配置 tmux
echo $PASSWD | sudo -S chmod +x $CURRENT_DIR/b-tmux/install-tmux.sh
cd $CURRENT_DIR/b-tmux
./install-tmux.sh $PASSWD

# 配置 powerline
echo $PASSWD | sudo -S chmod +x $CURRENT_DIR/b-powerline/install-powerline.sh
cd $CURRENT_DIR/b-powerline
./install-powerline.sh $PASSWD

# 配置 vim
cd $CURRENT_DIR/b-vim
echo $PASSWD | sudo -S chmod +x $CURRENT_DIR/b-vim/install-vim.sh
./install-vim.sh $PASSWD

cd $CURRENT_DIR