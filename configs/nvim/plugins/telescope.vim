Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep find_command=rg,--ignore,--hidden,--files,prompt_prefix=><cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
