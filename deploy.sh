# VIM
# ------------------------------------------------------------------------------

# Copy vim settings
cp .vimrc ~/.vimrc

# Download plugin manager (pathogen)
mkdir -p ~/.vim/autoload ~/.vim/bundle
wget https://tpo.pe/pathogen.vim -O ~/.vim/autoload/pathogen.vim

# Download plugins
cd ~/.vim/bundle
git clone --depth=1 https://github.com/bling/vim-airline.git
git clone --depth=1 https://github.com/airblade/vim-gitgutter.git
git clone --depth=1 https://github.com/tpope/vim-surround.git

