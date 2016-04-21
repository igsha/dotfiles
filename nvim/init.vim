call plug#begin('~/.vimplugged')

Plug 'mileszs/ack.vim' " {{{
nnoremap <Leader>q :cclose<CR>
nnoremap <Leader>n :cnext<CR>
nnoremap <Leader>p :cprev<CR>
nnoremap <Leader>o :copen<CR>
nnoremap <Leader>g :Ack<CR>
command -nargs=* AckWord :Ack <cword> <args>
" }}}
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic.git' " {{{
let g:syntastic_cpp_compiler_options = ' -std=c++0x'
" }}}
Plugin 'majutsushi/tagbar' " {{{
nmap <Leader>t :TagbarToggle<cr>
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
" }}}
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/buftabs' " {{{
set laststatus=2
"let g:buftabs_in_statusline = 0
let g:buftabs_only_basename = 1
let g:buftabs_separator = ":"
let g:buftabs_marker_start = "["
let g:buftabs_marker_end = "]"
let g:buftabs_marker_modified = ""
"set statusline=%{buftabs#statusline()}\ %=%h%m%r\ %-14.(%l,%c%V%)\ %P
" }}}
Plugin 'vim-scripts/unite.vim'
Plugin 'gregsexton/VimCalc' " {{{
au FileType vimcalc setlocal nolist
" }}}
Plugin 'kien/ctrlp.vim' " {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ }
" }}}
Plugin 'troydm/easybuffer.vim' " {{{
nmap <Leader>b :EasyBuffer<CR>
" }}}
Plugin 'AndrewRadev/linediff.vim'
Plugin 'vim-scripts/Align'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'embear/vim-localvimrc' " {{{
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0
let g:localvimrc_name = [ ".lvimrc", ".git/localvimrc" ]
" }}}
Plugin 'chumakd/conque-shell-mirror.git' " {{{
let g:ConqueTerm_ReadUnfocused = 0
let g:ConqueTerm_CloseOnEnd = 1
let g:ConqueTerm_StartMessages = 1
let g:ConqueTerm_Color = 0
au FileType conque_term setlocal nolist
" }}}
Plugin 'tyru/restart.vim' " {{{
let g:restart_sessionoptions = 'buffers,curdir,folds,help,options'
let g:restart_command = 'PureRestart'
command! -nargs=* Restart PureRestart --cmd "let g:vim_server_loaded = 1" <args>
set guiheadroom=0
" }}}
Plugin 'igsha/vim-server' " {{{
let g:vim_server_ignore_servernames = ["VIM", "VS_NET"]
" }}}
Plugin 'duellj/DirDiff.vim'
Plugin 'bling/vim-airline' " {{{
let g:airline_section_z = '%3p%% (0x%2B) %#__accent_bold#%4l%#__restore__#:%3c'
"}}}
Plugin 'AndrewRadev/simple_bookmarks.vim'
Plugin 'fidian/hexmode'
Plugin 'Shougo/vimshell.vim'
Plugin 'PProvost/vim-ps1'
Plugin 'chrisbra/csv.vim'
Plugin 'palopezv/vim-nroff'
Plugin 'awagner-mainz/vim-homekey'
Plugin 'bruno-/vim-man'
Plugin 'noah/vim256-color'

call plug#end()
