#!/bin/bash

C_GREEN="\033[1;32m"
C_YELLOW="\033[1;33m"
C_RESET="\033[0m"

# Deploy functions
# ------------------------------------------------------------------------------

DeployBash() {
    echo -e "${C_GREEN}* bash${C_RESET}"
    rm ~/.bashrc
    ln -sv $(pwd)/bashrc ~/.bashrc
}

DeployGit() {
    echo -e "${C_GREEN}* git${C_RESET}"
    rm ~/.gitconfig
    ln -sv $(pwd)/gitconfig ~/.gitconfig
}

DeployTerminator() {
    echo -e "${C_GREEN}* terminator${C_RESET}"
    mkdir -p ~/.config/terminator
    rm ~/.config/terminator/config
    ln -sv $(pwd)/terminator/config ~/.config/terminator/config
    cp -Rv terminator ~/.config
}

DeployTint2() {
    echo -e "${C_GREEN}* tint2${C_RESET}"
    mkdir -p ~/.config/tint2
    rm ~/.config/tint2/tint2rc
    ln -sv $(pwd)/tint2/tint2rc ~/.config/tint2/tint2rc
}

DeployI3() {
    echo -e "${C_GREEN}* i3${C_RESET}"
    mkdir -p ~/.i3
    rm ~/.i3/config
    ln -sv $(pwd)/i3/lock.sh ~/.i3/lock.sh
    ln -sv $(pwd)/i3/config ~/.i3/config
}

DeployVim() {
    # Symlink vim settings
    echo -e "${C_GREEN}* vim${C_RESET}"
    rm ~/.vimrc
    ln -sv $(pwd)/vimrc ~/.vimrc

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
        https://github.com/kien/ctrlp.vim.git
        https://github.com/jiangmiao/auto-pairs
        https://github.com/alvan/vim-closetag
        https://github.com/henrik/vim-indexed-search
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
}

# Parse args
# ------------------------------------------------------------------------------

case $1 in
    'all')
        DeployBash
        DeployGit
        DeployI3
        DeployTint2
        DeployTerminator
        DeployVim;;
    'bash')
        DeployBash;;
    'git')
        DeployGit;;
    'i3')
        DeployI3;;
    'tint2')
        DeployTint2;;
    'terminator')
        DeployTerminator;;
    'vim')
        DeployVim;;
    *)
        echo "Usage: $0 {all|bash|git|i3|tint2|terminator|vim}"
esac

