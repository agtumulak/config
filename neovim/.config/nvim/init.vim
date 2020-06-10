" vim plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'nvie/vim-flake8'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'tpope/vim-fugitive'
call plug#end()

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Remap keys for gotos
nmap <silent> <Leader>df <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

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
let g:gruvbox_contrast_dark='hard'
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

