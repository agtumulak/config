" vim plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'nvie/vim-flake8'
call plug#end()

" YouCompleteMe
nmap <Leader>r :YcmForceCompileAndDiagnostics<CR>
nmap <Leader>f :YcmCompleter FixIt<CR>
nmap <Leader>t :YcmCompleter GetType<CR>
nmap <Leader>df :YcmCompleter GoToDefinition<CR>
nmap <Leader>dc :YcmCompleter GoToDeclaration<CR>
let g:ycm_autoclose_preview_window_after_completion='1'

" xml editing: https://vim.fandom.com/wiki/Vim_as_XML_Editor
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
set foldlevelstart=999

" vim-flake8
autocmd FileType python map <buffer> <C-K> :call flake8#Flake8()<CR>

" fswitch: vi.stackexchange.com/a/6517
au! BufEnter *.cpp,*.cc,*.c let b:fswitchdst = 'h,hpp'    | let b:fswitchlocs = 'reg:/src/include/,../include,./'
au! BufEnter *.h,*.hpp      let b:fswitchdst = 'cpp,cc,c' | let b:fswitchlocs = 'reg:/include/src/,../src,./'
nmap <C-h> : FSHere<CR>

" fzf
nmap <Leader><space> :Files<CR>

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
set matchpairs+=<:>
set showmatch

" stackoverflow.com/a/4617156/5101335
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" stackoverflow.com/a/13216072/5101335
set wildmode=longest:full,full

" stackoverflow.com/a/30691754
set clipboard=unnamedplus

" keymappings
nmap <Space> <Leader>

" stackoverflow.com/a/657484/5101335
nmap <Leader>/ :noh<CR>

" clang-format: clang.llvm.org/docs/ClangFormat.html#vim-integration
autocmd FileType cpp map <C-K> :pyf /usr/local/share/clang/clang-format.py<cr>
autocmd FileType cpp imap <C-K> <c-o>:pyf /usr/local/share/clang/clang-format.py<cr>

