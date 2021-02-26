execute pathogen#infect()

"vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"git interface
Plugin 'tpope/vim-fugitive'
"filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim' 

map <C-n> :NERDTreeTabsToggle<CR>

"html
"  isnowfy only compatible with python not python3
" Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'nelstrom/vim-markdown-preview'
"python sytax checker
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'

"Javascript syntax checker
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
"Remember to npm install eslint --global
let g:syntastic_javascript_checkers = ['eslint']

"auto-completion stuff
"Plugin 'klen/python-mode'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'klen/rope-vim'
"Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
"code folding
Plugin 'tmhedberg/SimpylFold'
set nofoldenable

"Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'

call vundle#end()

" Mouse
if has('mouse')
  set mouse=a
endif

" Line column at 80 chars
set colorcolumn=81

" Autocomplete
:inoremap ( ()<Esc>i
:inoremap { {}<Esc>i
:inoremap [ []<Esc>i
:inoremap " ""<Esc>i
:inoremap ' ''<Esc>i

:inoremap <C-e> <Esc>/[)}"'\]>]<CR>:nohl<CR>a

colorscheme zellner

" Other stuff
filetype plugin indent on    " enables filetype detection
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
let g:SimpylFold_docstring_preview = 1

"autocomplete
"let g:ycm_autoclose_preview_window_after_completion=1

"custom keys
let mapleader=" "
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"turn on numbering
set nu

" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile * setlocal tabstop=2

"spaces for indents
au BufRead,BufNewFile * setlocal shiftwidth=2
au BufRead,BufNewFile * setlocal expandtab
au BufRead,BufNewFile * setlocal softtabstop=2

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Use UNIX (\n) line endings.
au BufNewFile * set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" Syntax!
syntax on

" make backspaces more powerfull
set backspace=indent,eol,start

"------------Start Python PEP 8 stuff----------------

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" For full syntax highlighting:
let python_highlight_all=1

" Keep indentation level from previous line:
autocmd FileType python set autoindent

"----------Stop python PEP 8 stuff--------------

"Auto indent on save.
filetype on
let blacklist = ['yaml']

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
let g:prettier#config#use_tabs = 'false'
autocmd BufWritePre * if index(blacklist, &ft) < 0 | PrettierAsync
