# Bash
# ------------------------------------------------------------------------------

cp .bashrc ~/.bashrc

# Terminator
# ------------------------------------------------------------------------------

#cp --parents terminator/config ~/.config

# VIM
# ------------------------------------------------------------------------------

# Copy vim settings
cp .vimrc ~/.vimrc

# Download plugin manager (pathogen)
mkdir -p ~/.vim/autoload ~/.vim/bundle
wget https://tpo.pe/pathogen.vim -O ~/.vim/autoload/pathogen.vim

# Vim plugins repositories
vim_plugins=(
    https://github.com/bling/vim-airline.git
    https://github.com/airblade/vim-gitgutter.git
    https://github.com/tpope/vim-surround.git
    https://github.com/ciaranm/detectindent.git
)

# Install plugins if not present
cd ~/.vim/bundle
for url in ${vim_plugins[@]}
do
    dir_name=`basename $url | sed 's/.git$//'`
    echo -e "\033[1;32m* $dir_name\033[0m"
    if [ ! -d $dir_name ]; then
        git clone --depth=1 $url $dir_name
    else
        echo $dir_name already exists
    fi
done
