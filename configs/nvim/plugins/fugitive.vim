Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

nmap <leader>g :Git<CR>
nmap <leader>gd :Git -p diff<CR>
nmap <leader>gaa :Git add .<CR>
nmap <leader>ga :Git add<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gb :GBranches<CR>
nmap <leader>g, :diffget //2<CR>
nmap <leader>g. :diffget //5<CR>
