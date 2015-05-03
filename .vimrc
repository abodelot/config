colorscheme elflord

" Enable 256 colors in terminal
set t_Co=256

" Auto-indent with 4 spaces
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Show line number
set number

" Show statusbar
set laststatus=2

" Highlight current line
set cursorline
hi CursorLine cterm=none ctermbg=darkblue
hi CursorLineNR ctermbg=darkmagenta

" Highlight all search occurences
set hlsearch
hi Search ctermbg=darkred ctermfg=white

" Enable incremental search
set incsearch

