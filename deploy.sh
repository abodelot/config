# vim
cp .vimrc ~/.vimrc
mkdir -p ~/.vim/autoload ~/.vim/bundle
wget https://tpo.pe/pathogen.vim -O ~/.vim/autoload/pathogen.vim

# vim plugins
git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline

