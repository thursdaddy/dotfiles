execute pathogen#infect()

set relativenumber
set number

set noshowmode
set hidden

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set copyindent
set ignorecase
set showmatch
set smarttab
set hlsearch
set incsearch

set history=1000
set undolevels=1000

set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
set undodir=~/.vim/tmp,.

syntax on
filetype plugin indent on

set pastetoggle=<F2>
nnoremap <F1> :set nonumber! norelativenumber!<CR>

let g:notes_directories = ['~/Docs/Notes/']

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
