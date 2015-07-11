" Settings
" ------------------------------------------------------------------------------

" Enable 256 colors in terminal
syntax on
colorscheme elflord
set t_Co=256

" Auto-indent
filetype plugin indent on

" Indent with 4 spaces, use soft-tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Show line numbers
set number

" Show status bar
set laststatus=2

" Show current command
set showcmd

" Keep at least 10 lines visible above and below cursor
set scrolloff=10

" Highlight current line
set cursorline

" Highlight all search occurences
set hlsearch

" Enable incremental search
set incsearch

" Set colorcolumn for column beyond 80
set colorcolumn=81
hi ColorColumn ctermbg=235

" Remove trailing whitespaces
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Keybindings
" ------------------------------------------------------------------------------

" Indent/unindent with tab without moving cursor
nnoremap <Tab> a<C-t><Esc>
nnoremap <S-Tab> a<C-d><Esc>
vnoremap <Tab> >
vnoremap <S-Tab> <

nnoremap <Space>w viw

" Fill rest of line with characters
function! FillLine(str)
    let tw = 81
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room
    if reps > 0
        .s/$/\=(repeat(a:str, reps))/
    endif
endfunction

nnoremap <F12> :call FillLine('-')<CR>
inoremap <F12> <Esc>:call FillLine('-')<CR>o

" Plugin configuration
" ----------------------------------------------------------------------------

" Initialize plugin loader
execute pathogen#infect()

" Detect indentation
autocmd BufReadPost * :DetectIndent

" vim-airline
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

" vim-surround extra shortcuts
nmap <Space>' ysiw'
nmap <Space>" ysiw"
nmap <Space>( ysiw)
nmap <Space>[ ysiw]
nmap <Space>{ ysiw{

