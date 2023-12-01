" Plugins that help us make vim more powerful.
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Filesystem plugins.
Plugin 'vifm/vifm.vim'

" Autocompletion plugins.
Plugin 'Valloric/YouCompleteMe' " Note: runs own tsserver from global.
Plugin 'dense-analysis/ale'
Plugin 'github/copilot.vim'

" Typescript plugins
Plugin 'leafgarland/typescript-vim'

" Syntax highlighting.
Plugin 'jparise/vim-graphql'
Plugin 'posva/vim-vue'

call vundle#end()

" Make vifm trigger on Cntrl-n
map <C-n> :vert TabVifm<CR>
let g:vifm_embed_term = 1
let g:vifm_embed_split = 1

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

" Set up vue linting. Note that this requires a global volar install, see
" https://github.com/dense-analysis/ale/pull/4552
let g:ale_linters = { 'vue': ['volar'] }

" Disable the ycm diagnostics UI because it conflicts with ALE.
let g:ycm_show_diagnostics_ui = 0

" Remap some keys to make jumping around easier.
" Use cntrl-m and cntrl-i to move on the jumplist.
:nnoremap <C-m> <C-O>

" Remap some useful ALE jump commands.
nnoremap agt :ALEGoToDefinition<CR>
nnoremap afr :ALEFindReferences<CR>
nnoremap ah :ALEHover<CR>
nnoremap as :ALESymbolSearch<CR>

" Autofix files with ALE.
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \  '*': ['remove_trailing_lines', 'trim_whitespace'],
      \  'javascript': ['prettier', 'eslint'],
      \  'typescript': ['prettier', 'eslint'],
      \  'javascriptreact': ['prettier', 'eslint'],
      \  'typescriptreact': ['prettier', 'eslint'],
      \  'css': ['prettier'],
      \  'html': ['prettier'],
      \  'json': ['prettier'],
      \  'vue': ['prettier'],
      \  'python': ['yapf'],
      \}

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

" Copilot. Requires nvm! This may require updates to the path as well.
let g:copilot_node_command = "/home/$USER/.nvm/versions/node/v19.9.0/bin/node"

" Clipboard support. Requires vim-gtk!
set clipboard=unnamedplus
