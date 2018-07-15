" vim plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'morhetz/gruvbox'
call plug#end()


" buftabline
let g:buftabline_show=1
let g:buftabline_numbers=1


" github.com/morhetz/gruvbox
colorscheme gruvbox
set background=dark


" tabs: vim.wikia.com/wiki/Indenting_source_code
set expandtab
set shiftwidth=2
set softtabstop=2


" misc
set number
set mouse=a
set colorcolumn=80
set updatetime=250


" stackoverflow.com/a/30691754
set clipboard=unnamedplus
