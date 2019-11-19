" Init: {{{1
set encoding=utf-8
scriptencoding utf-8

if &compatible | set nocompatible | endif

" Release autogroup in MyAutoCmd.
augroup MyyAutoCmd
  autocmd!
augroup END

" Utility: {{{1
" Judge os type. {{{2
let g:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let g:is_linux = !g:is_darwin

" Set path. {{{2
let $CACHE = expand('~/.cache')
if has('nvim')
  let $CACHE_HOME = expand('$CACHE/nvim')
  let $VIM_PATH = expand('~/.config/nvim')
  let $MYVIMRC = expand('~/.config/nvim/init.vim')
  let $BACKUP_PATH = expand('$CACHE/nvim/back')
else
  let $CACHE_HOME = expand('$CACHE/vim')
  let $VIM_PATH = expand('~/.vim')
  let $MYVIMRC = expand('~/.vimrc')
  let $MYGVIMRC = expand('~/.gvimrc')
  let $BACKUP_PATH = expand('$CACHE/vim/back')
endif

" Plugin: {{{1
let s:use_dein = 0
let s:use_minpac = 1

if s:use_dein
  runtime! dein.vim
elseif
  runtime! minpac.vim
else
  echom "No use plugin manager !"
endif

" Clipboard.
if g:is_darwin
  set clipboard=unnamed
else
  set clipboard=unnamed, unnamedplus
end

" Indent.
set autoindent
set smartindent
set breakindent

" Tab.
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab

" Display.
set number
set cursorline
set cursorcolumn
set laststatus=2
set cmdheight=2
set showmatch matchtime=1
set title
set list

set hidden
set history=100
set keywordprg=:help
set mouse=a
set pastetoggle=
set scrolloff=3
set textwidth=0
set timeoutlen=3500
set virtualedit=block
set whichwrap=b,s,[,],<,>
set wildmenu
set lazyredraw

" Search.
set ignorecase
set smartcase
set infercase
set wrapscan
set incsearch
set hlsearch

