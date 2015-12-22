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

" 2 spaces
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

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

set autowriteall

" Keybindings
" ------------------------------------------------------------------------------

" Navigate between layouts with Ctrl + Arrows
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Left> <C-W><C-H>
nnoremap <C-Right> <C-W><C-L>

" Indent/unindent with tab without moving cursor
nnoremap <Tab> a<C-t><Esc>
nnoremap <S-Tab> a<C-d><Esc>
vnoremap <Tab> >
vnoremap <S-Tab> <

" Select word under cursor
nnoremap ,w viw

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

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

nnoremap ,- :call FillLine('-')<CR>

" Plugin configuration
" ------------------------------------------------------------------------------

" Initialize plugin loader
execute pathogen#infect()

" vim-airline
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

" vim-surround extra shortcuts
nmap <Space>' ysiw'
nmap <Space>" ysiw"
nmap <Space>( ysiw)
nmap <Space>[ ysiw]
nmap <Space>{ ysiw{

" vim-ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|build|coverage|obj)$',
  \ 'file': '\v\.(o)$',
  \ }

