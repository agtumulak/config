call plug#begin()

Plug 'RRethy/nvim-base16'
Plug '/home/atumulak/.fzf' " https://github.com/junegunn/fzf/blob/master/README-VIM.md#fzf-vim-integration
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'v0.0.82'}
Plug 'psf/black', { 'branch': 'stable' }
Plug 'PeterRincker/vim-searchlight'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

set number
set clipboard+=unnamedplus " :help clipboard
set scrolloff=999
set wildmenu " https://stackoverflow.com/a/13043196
set wildmode=longest:full,full " https://stackoverflow.com/a/13043196
set updatetime=100 " https://github.com/airblade/vim-gitgutter#installation

" keymappings
nmap <Space> <Leader>

" stackoverflow.com/a/657484/5101335
nmap <Leader>/ :noh<CR>

" https://github.com/francoiscabrol/ranger.vim#opening-ranger-instead-of-netrw-when-you-open-a-directory
let g:ranger_replace_netrw = 1

" fzf
nmap <Leader>z :Files<CR>
nmap <Leader>b :Buffers<CR>
let g:fzf_preview_window = ['up:50%']

" :h provider-python
let g:python3_host_prog = '/home/atumulak/.conda/envs/neovim/bin/python'

" https://github.com/chriskempson/base16-shell#base16-vim-users
if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
    let base16colorspace=256
    colorscheme base16-$BASE16_THEME
endif


" coc: github.com/neoclide/coc.nvim#example-vim-configuration

" Use tab for trigger completion with characters ahead and navigate.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" To make <CR> to confirm selection of selected complete item or notify coc.nvim
" to format on enter, use: >
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
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
nmap <C-s> :CocCommand clangd.switchSourceHeader<CR>

" add some more contrast to popup menu background
highlight Pmenu ctermbg=White
highlight FgCocErrorFloatBgCocFloating ctermbg=White
highlight CocFloating ctermbg=White

highlight! link CocFloating Pmenu
highlight! link CocMenuSel PmenuSel

" vim-searchlight
highlight link Searchlight IncSearch

" black formatter
autocmd FileType python nnoremap <Leader>k :Black<CR>

" github.com/lukas-reineke/indent-blankline.nvim
lua << EOF
require("ibl").setup({indent = {char = {'│', '|', '¦', '┆', '┊'}}})
EOF
