"-------------------------------------------------------------------------------
" Configuration
"-------------------------------------------------------------------------------

" Enable smart indent
set smartindent

" Tabs are 4 columns
set tabstop=4

" Size of 1 level of indentation
set shiftwidth=4

" Indent with spaces, not tabs
set expandtab

" 2 spaces for ruby/web
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype crystal setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2           " .erb
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2      " .js
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2      " .ts
autocmd FileType javascriptreact setlocal sw=2 ts=2 sts=2 " .jsx
autocmd FileType typescriptreact setlocal sw=2 ts=2 sts=2 " .tsx
autocmd FileType yaml setlocal ts=2 sts=2 sw=2            " .yml, .yaml
autocmd FileType json setlocal ts=2 sts=2 sw=2            " .json
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2

" Make UI more responsive
set updatetime=300

" Use same clipboard then system
set clipboard=unnamedplus

" Disable swap files
set noswapfile

" Allow switching buffers without save
set hidden

" Show line numbers
set number

" Show current command
set showcmd

" Keep at least 10 lines visible above and below cursor
set scrolloff=10

" Highlight all search occurences
set hlsearch

" Enable incremental search
set incsearch

" Set ColorColumn for column beyond 100
set colorcolumn=101

" Highlight current line
set cursorline

" Use true colors intead of terminal colors
set termguicolors

" Auto reload files which have been changed outside of Vim
set autoread
autocmd FocusGained * :checktime

" Auto save files when focus is lost
autocmd FocusLost * :wa

" Auto save files when switching buffers
set autowriteall

" Remove trailing whitespaces
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

"-------------------------------------------------------------------------------
" Key bindings
"-------------------------------------------------------------------------------

" Use <space> as Leader key
let mapleader = " "

" Ctrl+z: undo
noremap <C-z> u

" Ctrl+jklm: Navigate between layouts
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-h> <C-W><C-H>
nnoremap <C-l> <C-W><C-L>

" Ctrl+q: close quickfix panel (search results)
nnoremap <silent> <C-q> :cclose<CR>

" Tab, Shift+Tab: Indent/unindent with tab without moving cursor
nnoremap <Tab> a<C-t><Esc>
nnoremap <S-Tab> a<C-d><Esc>
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" vv: select current line content (excluding \n)
nnoremap vv _v$h

" Surround current visual selection with pair characters
xnoremap ' c'<C-r>"'<Esc>
xnoremap " c"<C-r>""<Esc>
xnoremap ( c(<C-r>")<Esc>

" Go back to previous file
nnoremap <C-p> :b#<CR>

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------

" run :PlugInstall to install new plugins
" run :PlugUpdate to update all
call plug#begin()

" Navigation
Plug 'mg979/vim-visual-multi' " multi-cursor: Ctrl+Up/Ctrl+Down
Plug 'preservim/nerdtree' " file tree
Plug 'ggandor/leap.nvim'

" Telescope: search files (Ctrl+f), search content (Ctrl+g)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Home screen
Plug 'goolord/alpha-nvim'

" UI
Plug 'norcalli/nvim-colorizer.lua' " color for color codes
Plug 'kyazdani42/nvim-web-devicons'
Plug 'itchyny/lightline.vim' " status bar

" Edit
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP support
Plug 'scrooloose/nerdcommenter' " toggle comments
Plug 'vim-scripts/ReplaceWithRegister' " replace selection with register content: gr, gr{motion}

" Lang support
Plug 'leafgarland/typescript-vim' " TS support
Plug 'thoughtbot/vim-rspec' " Rspec
Plug 'vim-crystal/vim-crystal'
Plug 'rhysd/vim-clang-format'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

call plug#end()


"-------------------------------------------------------------------------------
" [alpha-nvim]
"-------------------------------------------------------------------------------

lua require'alpha'.setup(require'alpha.themes.startify'.config)

"-------------------------------------------------------------------------------
" [nerdcommenter] easy toggle for comments
"-------------------------------------------------------------------------------

" Align comments on the left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" F1: toggle comments
noremap <silent> <F1> :call nerdcommenter#Comment(0, "toggle")<CR>

"-------------------------------------------------------------------------------
" [coc.nvim] language server protocol
"-------------------------------------------------------------------------------

" Tab, Shift+Tab: select suggestion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Ctrl+Space: trigger autocomplete
inoremap <silent><expr> <c-space> coc#refresh()

" gp/gp: Jump to next/previous error
nnoremap gn <Plug>(coc-diagnostic-next)
nnoremap gp <Plug>(coc-diagnostic-prev)

" Autofix current error
nnoremap <F4> <Plug>(coc-fix-current)

" GoTo code navigation.
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap go <Plug>(coc-references)

" Leader+d: show documentation in preview window.
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  endif
endfunction
nnoremap <Leader>d :call ShowDocumentation()<CR>

"-------------------------------------------------------------------------------
" [Edit] vim-clang-format
"-------------------------------------------------------------------------------

autocmd FileType c ClangFormatAutoEnable

"-------------------------------------------------------------------------------
" [Git] vim-fugitive: git integration
"-------------------------------------------------------------------------------

" Use :G <command>
set diffopt+=vertical

"-------------------------------------------------------------------------------
" [Git] git-gutter: Display git statys +/-/~ in editor left gutter
"-------------------------------------------------------------------------------

" Do change background color of the git gutter
highlight clear SignColumn

" Sign color in git gutter
highlight GitGutterAdd          guifg=#009900 ctermfg=2
highlight GitGutterChange       guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete       guifg=#ff2222 ctermfg=1
highlight GitGutterChangeDelete guifg=#ff2222 ctermfg=4

"-------------------------------------------------------------------------------
" [UI] nvim-colorizer.lua: display color codes with color
"-------------------------------------------------------------------------------

lua require'colorizer'.setup()

lua require('leap').set_default_keymaps()

"-------------------------------------------------------------------------------
" [UI] lightline.vim: Display a nice status bar below editor
"-------------------------------------------------------------------------------

" Display fullpath for current file, instead of filename only
function! LightLineFilename()
  return expand('%')
endfunction

" Display Vim mode
function! LightlineMode()
  return expand('%:t') =~# '^__Tagbar__' ? 'Tagbar':
        \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ lightline#mode()
endfunction

" Vim mode is already displayed in status bar, no need to print it at the bottom
set noshowmode

let g:lightline = {
 \   'active': {
 \     'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']]
 \   } ,
 \   'component_function': {
 \     'gitbranch': 'FugitiveHead',
 \     'filename': 'LightLineFilename',
 \     'mode': 'LightlineMode',
 \   },
 \   'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
 \   'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
 \   'colorscheme': 'one',
 \ }

"-------------------------------------------------------------------------------
" [telescope] Search files, live grep
"-------------------------------------------------------------------------------

" Ignore some dirs, do not ignore dot files
lua require('telescope').setup{ defaults = { file_ignore_patterns = {".git/", "^obj/", "^dist/", "^vendor/"} }, pickers = { find_files = { hidden = true } } }

" Find files using Telescope command-line sugar.
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
" nnoremap <C-h> <cmd>Telescope help_tags<cr>

" f: search selected text
vnoremap f "zy:Telescope live_grep default_text=<C-r>z<cr>

" ------------------------------------------------------------------------------
" [Navigation] nerdtree: file browser in sidebar
" ------------------------------------------------------------------------------

" Ctrl+t to toggle, navigate with j/k, open dir/file with o
map <silent> <C-t> :NERDTreeToggle<CR>

" ------------------------------------------------------------------------------
" Color scheme
" ------------------------------------------------------------------------------

" Selected line in quickfix panel
hi QuickFixLine guibg=#111111

" Non content (such as ~ on left gutter)
hi NonText guifg=#4a5171

" Line number
hi LineNr guifg=#4a5171

" Set a different background color for Normal and Non Current
set winhighlight=Normal:MyNormal,NormalNC:MyNormalNC
" hi MyNormal guibg=#282a36 guifg=#f0f0f0
" hi MyNormalNC guibg=#313445 guifg=#b0b0c0
hi MyNormal guibg=#000000 guifg=#f0f0f0
hi MyNormalNC guibg=#111111 guifg=#a0a0a0

" Current line
hi CursorLine guibg=#14151b

" Current line number
hi CursorLineNr guifg=#f0f0f0

" Column limit hint
hi ColorColumn guibg=#313445

" Popup for Coc diagnostic
hi CocFloating guibg=#221100

" Suggestion popup
hi Pmenu guibg=#453969
hi PmenuSel guibg=#614895

" Search occurences
hi Search guibg=#ff0088 guifg=#ffeef0

hi comment guifg=#00e0f0
