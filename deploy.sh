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
    ln -sv $(pwd)/git/gitconfig ~/.gitconfig
}

DeployTerminator() {
    echo -e "${C_GREEN}* terminator${C_RESET}"
    mkdir -p ~/.config/terminator
    rm ~/.config/terminator/config
    ln -sv $(pwd)/terminator/config ~/.config/terminator/config
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

DeployNeoVim() {
    echo -e "${C_GREEN}* neovim${C_RESET}"
    mkdir -p ~/.config/nvim
    rm ~/.config/nvim/init.vim
    ln -sv $(pwd)/neovim/init.vim ~/.config/nvim/init.vim
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
        DeployNeoVim;;
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
    'nvim')
        DeployNeoVim;;
    *)
        echo "Usage: $0 {all|bash|git|i3|tint2|terminator|nvim}"
esac

