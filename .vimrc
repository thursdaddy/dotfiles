syntax on

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
"set colorcolumn=80

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
Plug 'morhetz/gruvbox'
Plug 'edkolev/tmuxline.vim'
Plug 'pearofducks/ansible-vim'
Plug 'tpope/vim-rhubarb'
Plug 'stsewd/fzf-checkout.vim'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

call plug#end()

let g:ansible_with_keywords_highlight = 'Constant'


" THEME
if !exists('g:airline_theme_map')
   let g:airline_theme_map = {
      \ 'gruvbox.*': 'tomorrow',
      \ }
else
   let g:airline_theme_map['gruvbox.*'] = 'tomorrow'
endif
let g:airline_theme='base16_gruvbox_dark_hard'


autocmd vimenter * ++nested hi Normal ctermbg=NONE guibg=NONE

set background=dark
highlight Colorcolumn ctermbg=NONE guibg=NONE
highlight Normal ctermbg=NONE guibg=NONE

colorscheme gruvbox
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = 'hard'

" BINDS
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" KEY MAPPINGS
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
nnoremap <C-p> :GFiles<CR>
nnoremap <C-o> :Files<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rl :so ~/.vimrc<CR>

" GITFUGITIVE
nmap <leader>gst :G<CR>
nmap <leader>gd :G -p diff<CR>
nmap <leader>gaa :G add .<CR>
nmap <leader>ga :G add<CR>
nmap <leader>gcmsg :G commit<CR>
nmap <leader>gb :GBranches<CR>

nmap <C-e> :Lexplore<CR>

let g:fugitive_gitlab_domains = ['https://git.thurs.pw']

" toggle relative number
nnoremap <silent> <leader>n :set relativenumber! <bar> set nu!<CR>

" Whitespace Trimmer
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
set autochdir
"function! ToggleVExplorer()
"  if exists("t:expl_buf_num")
"      let expl_win_num = bufwinnr(t:expl_buf_num)
"      if expl_win_num != -1
"          let cur_win_nr = winnr()
"          exec expl_win_num . 'wincmd w'
"          close
"          exec cur_win_nr . 'wincmd w'
"          unlet t:expl_buf_num
"      else
"          unlet t:expl_buf_num
"      endif
"  else
"      exec '1wincmd w'
"      Vexplore
"      let t:expl_buf_num = bufnr("%")
"  endif
"endfunction
"map <silent> <C-E> :call ToggleVExplorer()<CR>
