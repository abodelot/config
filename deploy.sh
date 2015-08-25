#!/bin/bash

C_GREEN="\033[1;32m"
C_YELLOW="\033[1;33m"
C_RESET="\033[0m"

# Bash
# ------------------------------------------------------------------------------

echo -e "${C_GREEN}* bash${C_RESET}"
cp .bashrc ~/.bashrc -v

# Git
# ------------------------------------------------------------------------------

echo -e "{C_GREEN}* git${C_RESET}"
cp .gitconfig ~/.gitconfig -v

# Terminator
# ------------------------------------------------------------------------------

#cp --parents terminator/config ~/.config

# VIM
# ------------------------------------------------------------------------------

# Copy vim settings
echo -e "${C_GREEN}* vim${C_RESET}"
cp .vimrc ~/.vimrc -v

# Download plugin manager (pathogen)
if [ -f ~/.vim/autoload/pathogen.vim ]; then
    echo vim pathogen already installed
else
    mkdir -p ~/.vim/autoload ~/.vim/bundle
    wget https://tpo.pe/pathogen.vim -O ~/.vim/autoload/pathogen.vim
fi

# Vim plugins repositories
vim_plugins=(
    https://github.com/bling/vim-airline.git
    https://github.com/airblade/vim-gitgutter.git
    https://github.com/tpope/vim-surround.git
    https://github.com/ciaranm/detectindent.git
    https://github.com/kien/ctrlp.vim.git
)

# Install plugins if not present
cd ~/.vim/bundle
for url in ${vim_plugins[@]}
do
    plugin_name=`basename $url | sed 's/.git$//'`
    if [ -d $plugin_name ]; then
        echo "${plugin_name} already installed"
    else
        echo -e "${C_YELLOW}installing vim plugin: ${plugin_name}${C_RESET}"
        git clone --depth=1 $url $plugin_name
    fi
done

