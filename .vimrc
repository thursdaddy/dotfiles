execute pathogen#infect()

set relativenumber
set number

set noshowmode
set nocompatible
set hidden

set tabstop=4
set autoindent
set copyindent
set shiftwidth=4
set ignorecase
set showmatch
set smarttab
set hlsearch
set incsearch

set history=1000
set undolevels=1000
set nobackup
set noswapfile
set pastetoggle=<F2>

syntax on
filetype plugin indent on

" NERDTree CONFIG
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" TMUX WINDOW RENAMING
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window '" . expand("%:t")  . "'")
autocmd VimLeave * call system("tmux setw automatic-rename")

" LIGHTLINE AND STATUSLINE CONFIG
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
	  \   'left': [ [ 'mode', 'paste' ],
	  \           [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ]
	  \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
	  \ }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
