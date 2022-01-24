syntax on                   " syntax highlighting
set hidden
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set relativenumber
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
set mouse=a                 " enable mouse click
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
"set spell                 " enable spell check (may need to download language package)
set noswapfile            " disable creating swap file
set backupdir=~/.cache/vim " Directory to store backup files.
set smartcase
set list
set scrolloff=4
set sidescrolloff=4

" Bindings
let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvmim/init.vim<CR>
nmap <leader>vr :source ~/.config/nvim/init.vim<CR>
map gf :edit >cfile><cr>

" Reselect visual selection after indent
vnoremap < <gv
vnoremap > >gv

vnoremap y myy`y

imap ,, <Esc>A,<Esc>
imap ;; <Esc>A;<Esc>

cmap w!! %!sudo tee > /dev/null %

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

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,prompt_prefix=><cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'vim-utils/vim-man'
Plug 'projekt0n/github-nvim-theme'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tweekmonster/gofmt.vim'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'edkolev/tmuxline.vim'
Plug 'pearofducks/ansible-vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'machakann/vim-highlightedyank'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

call plug#end()

colorscheme github_dark_default

