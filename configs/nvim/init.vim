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
set splitright
set nojoinspaces
set listchars=tab:▸\ ,trail:·
set list
set scrolloff=4
set sidescrolloff=4

" Bindings
let mapleader = "\<space>"

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap <leader>ve :edit ~/.config/nvmim/init.vim<CR>
nmap <leader>vr :source ~/.config/nvim/init.vim<CR>

nmap <leader>k :nohlsearch<CR>
nmap <leader>Q :bufdo bdelete<cr>

" Reselect visual selection after indent
vnoremap < <gv
vnoremap > >gv

vnoremap y myy`y
vnoremap Y myY`y
nnoremap Y y$

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Quicky escape to normal mode
imap jj <esc>

" Add <char> to end of line
imap ,, <Esc>A,<Esc>
imap ;; <Esc>A;<Esc>

" sudo save
cmap w!! %!sudo tee > /dev/null %

" Open file even if non-existent
map gf :edit <cfile><cr>

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/ale.vim
source ~/.config/nvim/plugins/ansible.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/commentary.vim
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/highlightedyank.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/polyglot.vim
source ~/.config/nvim/plugins/repeat.vim
source ~/.config/nvim/plugins/signify.vim
source ~/.config/nvim/plugins/smooth-scroll.vim
source ~/.config/nvim/plugins/surround.vim
source ~/.config/nvim/plugins/telescope.vim
source ~/.config/nvim/plugins/themes.vim
source ~/.config/nvim/plugins/tmuxline.vim
source ~/.config/nvim/plugins/undotree.vim

call plug#end()

" Set colorscheme from themes.vim
colorscheme ayu
