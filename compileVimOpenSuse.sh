# remove current vim
sudo zypper rm vim vim-runtime vim-gnome vim-tiny vim-gui-common

# removes current link for vim
sudo rm -rf /usr/local/share/vim /usr/bin/vim

# add ppa for newest version of ruby (currently, as of 06/06/2017, ruby v2.4)
#sudo apt-add-repository ppa:brightbox/ruby-ng
#sudo apt-get update

# installs everything needed to make/configure/build Vim
sudo zypper in \
    lua51-luajit \
    lua51-luajit-devel \
    lua51-devel \
    python-devel \
    python3-devel \
    ruby2.6 \
    ruby2.6-devel \
    devel_perl \
    ncurses5-devel \
    atk-devel \
    libX11 \
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
./configure \
--enable-multibyte \
--enable-perlinterp=dynamic \
--enable-rubyinterp=dynamic \
--with-ruby-command=/usr/bin/ruby \
--enable-pythoninterp=dynamic \
--with-python-config-dir=/usr/bin/python \
--enable-python3interp \
--with-python3-config-dir=/usr/bin/python3 \
--enable-luainterp \
--with-luajit \
--enable-cscope \
--enable-gui=auto \
--with-features=huge \
--with-x \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--with-compiledby="ERICK ROCHA <contato@erickpatrick.net>" \
--enable-fail-if-missing

# this this is the compilation step. It should also create the symlink of the binary
# one /usr/bin folder
make && sudo make install > viminstal.log
# To be able to access the new vim instaltion we need to refresh bash/zsh/fish
