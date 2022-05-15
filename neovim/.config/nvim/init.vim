" vim plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'tpope/vim-fugitive'
call plug#end()


" coc: github.com/neoclide/coc.nvim#example-vim-configuration

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Use tab for trigger completion with characters ahead and navigate.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Switch between source and header files
nmap <C-h> :CocCommand clangd.switchSourceHeader<CR>

" fzf
nmap <Leader><space> :Files<CR>

" vimtex
" forward search: <Leader>-l-v
" backward search: Command-Shift-Click
let g:vimtex_view_method='skim'
" jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
augroup vimtex_common
  autocmd!
  autocmd FileType tex call writefile([v:servername], "/tmp/vimtexserver.txt")
augroup END

" neovim.io/doc/user/provider.html#python-virtualenv
let g:python3_host_prog = '/opt/homebrew/Caskroom/miniconda/base/envs/neovim/bin/python'

" github.com/chriskempson/base16-vim
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
exe 'highlight LspCxxHlGroupMemberVariable guifg=#' . g:base16_gui05


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
set termguicolors " jdhao.github.io/2018/10/19/tmux_nvim_true_color/

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
autocmd FileType cpp map <C-K> :py3f /opt/homebrew/Cellar/clang-format/14.0.2/share/clang/clang-format.py<cr>
autocmd FileType cpp imap <C-K> <c-o>:py3f /opt/homebrew/Cellar/clang-format/14.0.2/share/clang/clang-format.py<cr>
