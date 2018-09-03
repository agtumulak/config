" vim plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
call plug#end()


" buftabline
let g:buftabline_show=1
let g:buftabline_numbers=2
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)


" vimtex: github.com/lervag/vimtex/wiki/introduction#neovim
let g:vimtex_view_method='skim' " PDF-Tex Sync: /usr/local/miniconda3/bin/nvr --remote-silent %file -c %line
let g:vimtex_compiler_progname='/usr/local/miniconda3/bin/nvr'
" forward search: <Leader>-l-v
" backward search: Command-Shift-Click


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


" keymappings
map <Space> <Leader>
