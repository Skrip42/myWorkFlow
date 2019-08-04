# remove current vim
sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common

# removes current link for vim
sudo rm -rf /usr/local/share/vim /usr/bin/vim

# add ppa for newest version of ruby (currently, as of 06/06/2017, ruby v2.4)
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update

# installs everything needed to make/configure/build Vim
sudo apt-get -y install liblua5.1-dev luajit libluajit-5.1-dev libjuajit-5.1-2 python-dev python3-dev ruby-dev ruby2.5 ruby2.5-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev

#Optional: so vim can be uninstalled again via `dpkg -r vim`
sudo apt-get -y install checkinstall

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
--enable-perlinterp=yes \
--enable-rubyinterp=yes \
--enable-pythoninterp=yes \
--enable-python3interp \
--enable-cscope \
--enable-gui=auto \
--enable-fontset \
--enable-largefile \
--enable-fail-if-missing
--disable-netbeans \
--with-ruby-command=/usr/bin/ruby \
#--with-python-config-dir=/usr/bin/python \ # or path to python3
--with-python3-config-dir=/usr/bin/python3 \ # or path to python3
--enable-luainterp \
--with-luajit \
--with-features=huge \
--with-client-server \
--with-x \
--with-compiledby="ERICK ROCHA <contato@erickpatrick.net>" \

# this this is the compilation step. It should also create the symlink of the binary
# one /usr/bin folder
make && sudo make install

# To be able to access the new vim instaltion we need to refresh bash/zsh/fish
exec zsh
