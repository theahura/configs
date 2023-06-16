" Plugins that help us make vim more powerful.
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Filesystem plugins.
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

" Autoformating plugins.
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

" Autocompletion plugins.
Plugin 'Valloric/YouCompleteMe' " Note: runs own tsserver from global.
Plugin 'dense-analysis/ale'

" Typescript plugins
Plugin 'leafgarland/typescript-vim'

" Syntax highlighting.
Plugin 'jparise/vim-graphql'

call vundle#end()
call glaive#Install()

" Set up useful defaults for codefmt.
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json,vue,javascript,javascriptreact,typescript,typescriptreact AutoFormatBuffer prettier
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType rust AutoFormatBuffer rustfmt
augroup END
Glaive codefmt plugin[mappings]

" Run autoformatting on save.
let blacklist = ['yaml']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | FormatCode

" Make nerdtree trigger on Cntrl-n
map <C-n> :NERDTreeTabsToggle<CR>

" Mouse
if has('mouse')
  set mouse=a
endif

" Line column at 80 chars
set colorcolumn=80

" Autocomplete brackets and quotes.
:inoremap ( ()<Esc>i
:inoremap { {}<Esc>i
:inoremap [ []<Esc>i
:inoremap " ""<Esc>i
:inoremap ' ''<Esc>i
:inoremap < <><Esc>i
:inoremap <C-e> <Esc>/[)}"'\]>]<CR>:nohl<CR>a

" Disable the ycm diagnostics UI because it conflicts with ALE.
let g:ycm_show_diagnostics_ui = 0

" Remap some keys to make jumping around easier. 
" Use cntrl-m and cntrl-i to move on the jumplist.
:nnoremap <C-m> <C-O>

" Remap some useful ALE jump commands. 
nnoremap agt :ALEGoToDefinition<CR>
nnoremap afr :ALEFindReferences<CR>

" Colors!
colorscheme default 
hi SpellBad ctermbg=DarkGrey
hi Search ctermbg=Black ctermfg=White

" Other stuff
filetype plugin indent on    " enables filetype detection

" Useful defaults: line numbering.
set nu

" Number of spaces that a pre-existing tab is equal to. We use 2.
au BufRead,BufNewFile * setlocal tabstop=2
au BufRead,BufNewFile * setlocal shiftwidth=2
au BufRead,BufNewFile * setlocal expandtab
au BufRead,BufNewFile * setlocal softtabstop=2

" Use UNIX (\n) line endings.
au BufNewFile * set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" make backspaces more powerfull.
set backspace=indent,eol,start

set re=0
set tabpagemax=30

" Copilot. Requires nvm!
let g:copilot_node_command = "/home/soot/.nvm/versions/node/v19.8.1/bin/node"
