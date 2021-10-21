# remove current vim
sudo zypper rm vim vim-runtime vim-gnome vim-tiny vim-gui-common

# removes current link for vim
sudo rm -rf /usr/local/share/vim /usr/bin/vim

# installs everything needed to make/configure/build Vim
sudo zypper in \
    luajit \
    luajit-devel \
    lua51-devel \
    python-devel \
    python3-devel \
    ruby2.6 \
    ruby2.6-devel \
    ncurses5-devel \
    atk-devel \
    xorg-X11-devel \
    libXpm-devel \
    libXt-devel

#Optional: so vim can be uninstalled again via `dpkg -r vim`
#sudo apt-get -y install checkinstall

# clones vim repository so we can build it from scratch
cd ~
git clone https://github.com/vim/vim
cd vim
git pull && git fetch

# In case Vim was already installed. This can throw an error if not installed, 
# it's the nromal behaviour. That's no need to worry about it
cd src
make distclean
cd ..

# update to use the correct python 2.7/3.x config path also change 'YOUR NAME' to
# your real name
sudo ./configure \
--enable-multibyte \
--enable-perlinterp=dynamic \
--enable-rubyinterp=dynamic \
--with-ruby-command=/usr/bin/ruby \
--enable-python3interp=yes \
--with-python3-command=python3 \
--enable-luainterp \
--with-luajit \
--enable-cscope \
--enable-gui=auto \
--with-features=huge \
--with-x \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--with-compiledby="skrip <skrip42@gmail.com>" \
--enable-fail-if-missing

# this this is the compilation step. It should also create the symlink of the binary
# one /usr/bin folder
sudo make && sudo make install > viminstal.log
