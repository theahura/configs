execute pathogen#infect()

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
Plugin 'Valloric/YouCompleteMe'

call vundle#end()
call glaive#Install()

" Set up useful defaults for codefmt.
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END
Glaive codefmt plugin[mappings]

" Run autoformatting on save.
autocmd BufWritePost * FormatCode

" Make nerdtree trigger on Cntrl-n"
map <C-n> :NERDTreeTabsToggle<CR>

" Syntastic defaults.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Mouse
if has('mouse')
  set mouse=a
endif

" Line column at 80 chars
set colorcolumn=81

" Autocomplete brackets and quotes.
:inoremap ( ()<Esc>i
:inoremap { {}<Esc>i
:inoremap [ []<Esc>i
:inoremap " ""<Esc>i
:inoremap ' ''<Esc>i
:inoremap <C-e> <Esc>/[)}"'\]>]<CR>:nohl<CR>a

" Colors!
colorscheme zellner

" Other stuff
filetype plugin indent on    " enables filetype detection

" Useful defaults: line numbering and syntax highlighting.
set nu
syntax on

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
