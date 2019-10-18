" Settings
" ------------------------------------------------------------------------------

" run :PlugInstall to install new plugins
call plug#begin()
"Plug 'roxma/nvim-completion-manager'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-matchquote'
" Status bar
Plug 'itchyny/lightline.vim'
" Filepath fuzzy search
Plug 'ctrlpvim/ctrlp.vim'
" Display number of search matches
Plug 'google/vim-searchindex'
Plug 'mhinz/vim-grepper'
" Syntax highlight for VueJS components
Plug 'posva/vim-vue'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
call plug#end()

" Enable 256 colors in terminal
syntax enable
colorscheme elflord
set t_Co=256

" Auto-indent
filetype indent off
filetype plugin on
set autoindent
set smartindent

" Indent with 4 spaces, use soft-tabs
set tabstop=4
set shiftwidth=4
set expandtab

" 2 spaces for ruby/web
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype vue setlocal ts=2 sts=2 sw=2
autocmd Filetype vuejs setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2
autocmd Filetype sh setlocal ts=2 sts=2 sw=2
autocmd Filetype coffee setlocal ts=2 sts=2 sw=2

" .mjs => javascript node module
au BufRead *.mjs setf javascript

set hidden

let mapleader = ","

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
autocmd InsertLeave * update

set updatetime=500

" Copy to system clipboard in addition to vim clipboard
set clipboard+=unnamedplus

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

" Cut/Copy/Paste
nnoremap p "+gp
vnoremap y "+y
vnoremap x "+x

nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

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


" rspec
function! RSpecFile()
  execute("!clear && bundle exec rspec " . expand("%p"))
endfunction
map <leader>R :call RSpecFile() <CR>
command! RSpecFile call RSpecFile()

function! RSpecCurrent()
  execute("!clear && bundle exec rspec " . expand("%p") . ":" . line("."))
endfunction
map <leader>r :call RSpecCurrent() <CR>
command! RSpecCurrent call RSpecCurrent()

" Plugin configuration
" ------------------------------------------------------------------------------

" vim-surround extra shortcuts
nmap <Space>' ysiw'
nmap <Space>" ysiw"
nmap <Space>( ysiw)
nmap <Space>[ ysiw]
nmap <Space>{ ysiw{


" closetag
let g:closetag_filenames = "*.html,*.xml,*.erb"

"-------------------------------------------------------------------------------
" lightline: https://github.com/itchyny/lightline.vim
" Display a status bar below editor
"-------------------------------------------------------------------------------

let g:lightline = {
  \ 'component_function': {
  \   'filename': 'LightLineFilename'
  \ }
  \ }
" Display current file fullpath
function! LightLineFilename()
  return expand('%')
endfunction

" ------------------------------------------------------------------------------
" ctrlp: https://github.com/ctrlpvim/ctrlp.vim
" File finder with <ctrl> + p
"-------------------------------------------------------------------------------

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|coverage|obj)$',
  \ 'file': '\v\.(o)$',
  \ }

" -----------------------------------------------------------------------------
" vim-grepper: https://github.com/mhinz/vim-grepper
" Search occurences of current word with <leader> + j
" ------------------------------------------------------------------------------

" Search word under cursor using rg
nnoremap <leader>j :Grepper -tool rg -cword -noprompt<cr>
let g:grepper = {}
" Use location list for the matches instead of quickfix
let g:grepper.quickfix = 0
" Auto-close Location-List on CR
:autocmd FileType qf nmap <buffer> <cr> <cr>:lcl<cr>

"-------------------------------------------------------------------------------
" nerd commenter: https://github.com/scrooloose/nerdcommenter
" Toggle comments with <leader> + c + <space>
"-------------------------------------------------------------------------------

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

"-------------------------------------------------------------------------------
" git-gutter: https://github.com/airblade/vim-gitgutter
" Display +/-/~ symbols in editor left gutter
"-------------------------------------------------------------------------------

let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4
