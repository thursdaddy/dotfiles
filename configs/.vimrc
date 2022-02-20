syntax on
set nocompatible

set relativenumber
set guicursor=
set noshowmatch
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt-=preview
set cmdheight=1
set updatetime=50
set shortmess+=c
set colorcolumn=80

" Install Plug if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

map \ zz
map Y y$

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tweekmonster/gofmt.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-dispatch'
Plug 'edkolev/tmuxline.vim'
Plug 'pearofducks/ansible-vim'
Plug 'tpope/vim-rhubarb'
Plug 'stsewd/fzf-checkout.vim'
Plug 'machakann/vim-highlightedyank'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

call plug#end()

let g:ansible_with_keywords_highlight = 'Constant'
let g:highlightedyank_highlight_duration = 1000

" THEME
if !exists('g:airline_theme_map')
   let g:airline_theme_map = {
      \ 'gruvbox.*': 'owo',
      \ }
else
   let g:airline_theme_map['gruvbox.*'] = 'owo'
endif
let g:airline_theme='owo'

autocmd vimenter * ++nested hi Normal ctermbg=NONE guibg=NONE

colorscheme gruvbox
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = 'hard'
set background=dark

" BINDS
let mapleader = " "

nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rl :so ~/.vimrc<CR>
nmap <C-e> :Lexplore<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-o> :Files<CR>
nmap <leader>o :GBrowse<CR>

" GITFUGITIVE
nmap <leader>g :Git<CR>
nmap <leader>gd :Git -p diff<CR>
nmap <leader>gaa :Git add .<CR>
nmap <leader>ga :Git add<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gb :GBranches<CR>
nmap <leader>g, :diffget //2<CR>
nmap <leader>g. :diffget //3<CR>
nmap <leader><esc> <nop><CR>


" toggle relative number
nnoremap <silent> <leader>n :set relativenumber! <bar> set nu!<CR>

" Whitespace Trimmer
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" NERDTree, jk its netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
set autochdir

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
