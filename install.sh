#!/bin/bash
echo "----installing"
if [ -x "$(command -v zypper)" ]; then
    echo 'zypper package-manager detected'
    declare packageManager="zypper"
elif [ -x "$(command -v apt-get)" ]; then
    echo 'apt-get package-manager detected'
    declare packageManager="apt-get"
fi

echo "----buildVim"
if [packageManager == 'zypper']; then
    source compileVimOpenSuse.sh
elif
    source compileVimUbuntu.sh
fi

cd ~
echo "----unitilts installing"
${packageManager} install fzf
${packageManager} install the_silver_searcher

echo "----tmux installing"
${packageManager} install tmux

echo "----zsh installing"
${packageManager} install zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh

echo "----vim installing"
echo "---- ---- create vim temp dir"
mkdir .vimbackup -m +wrx
mkdir .vimswap -m +wrx
mkdir .vimundo -m +wrx

echo "---- ---- get vim plugins"
git clone https://github.com/Skrip42/myVimSettings.git .vim
cd ~/.vim 
git submodule init
git submodule update --init --recursive

echo "---- ---- install youCompleteMe"
if [packageManager == 'zypper']; then
    ${packageManager} install cmake
    ${packageManager} install gcc-c++
    ${packageManager} install make
    ${packageManager} install python3-devel
else 
    ${packageManager} install cmake3
    ${packageManager} install python3-dev
    ${packageManager} install build-dssential
fi
cd ~/.vim/bundle/YouCompleteMe

python3 install.py --clangd-completer
echo "---- copy config file"
cd ~/myWorkFlow
mv ../.zshrc ./backups/.zshrc
mv ../.vimrc ./backups/.vimrc
mv ../.bashrc ./backups/.bashrc
mv ../.tmux.conf ./backups/.tmux.conf
ln ../.vim/.vimrc ../.vimrc
ln ./configFiles/.zshrc ../.zshrc
ln ./configFiles/.bashrc ../.bashrc
ln ./configFiles/.tmux.conf ../.tmux.conf

echo "---- install app"
cd ~
mkdir app
echo "---- ---- install ctags"
wget "https://github.com/shawncplus/phpcomplete.vim/raw/master/misc/ctags-5.8_better_php_parser.tar.gz" -O ctags-5.8_better_php_parser.tar.gz
 tar xvf ctags-5.8_better_php_parser.tar.gz
cd ctags
./configure
make
sudo make install
echo "---- finishing install please reboot"

