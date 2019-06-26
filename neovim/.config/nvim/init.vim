" vim plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ericcurtin/CurtineIncSw.vim'
call plug#end()


" CurtineINcSw
map <C-h> :call CurtineIncSw()<CR>


" fzf
map <Leader><space> :Files<CR>


" vimtex: github.com/lervag/vimtex/wiki/introduction#neovim
let g:vimtex_view_method='skim' " PDF-Tex Sync: nvr --remote-silent %file -c %line
let g:vimtex_compiler_progname='/usr/local/miniconda3/envs/neovim-py3/bin/nvr'
" forward search: <Leader>-l-v
" backward search: Command-Shift-Click


" neovim.io/doc/user/provider.html#python-virtualenv
let g:python_host_prog  = '/usr/local/miniconda3/envs/neovim-py2/bin/python'
let g:python3_host_prog = '/usr/local/miniconda3/envs/neovim-py3/bin/python'


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


" stackoverflow.com/a/4617156/5101335
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/


" stackoverflow.com/a/13216072/5101335
set wildmode=longest:full,full


" stackoverflow.com/a/30691754
set clipboard=unnamedplus


" keymappings
map <Space> <Leader>
