set encoding=utf-8
scriptencoding utf-8
filetype off

" Utility:
let g:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let g:is_linux = !g:is_darwin

" Clipboard.
if g:is_darwin
  set clipboard=unnamed
else
  set clipboard=unnamed, unnamedplus
end

" Set path.
let $CACHE = expand('~/.cache')
let $CACHE_HOME = expand('$CACHE/vim')
let $VIM_PATH = expand('~/.vim')
let $MYVIMRC = expand('~/.vimrc')
" If installed using Homebrew
set runtimepath+=/usr/local/opt/fzf

" Use minpac.{{{
set packpath^=$CACHE_HOME
let s:package_home = $CACHE_HOME . '/pack/packages'
let s:minpac_dir = s:package_home . '/opt/minpac'
if has('vim_starting')
  if !isdirectory(s:minpac_dir)
    echo 'Install minpac ...'
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
  endif
endif
"}}}

" Init minpac.{{
if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Add about vim plugins
  call minpac#add('Townk/vim-autoclose')
  call minpac#add('honza/vim-snippets')
  call minpac#add('ntpeters/vim-better-whitespace')
  call minpac#add('terryma/vim-multiple-cursors')
  call minpac#add('tomtom/tcomment_vim')
  call minpac#add('tpope/vim-surround')
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('w0rp/ale')
  call minpac#add('lambdalisue/fern.vim')
  call minpac#add('editorconfig/editorconfig-vim')

  " Style
  call minpac#add('rafi/awesome-vim-colorschemes')
endif
"}}}

" Define user commands for updating/cleaning the plugins.{{{
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
packadd minpac
"}}}

" Vim set config.{{{
set backspace=indent,eol,start " http://vim.wikia.com/wiki/Backspace_and_delete_problems
set fileencoding=utf-8  " Set encoding
set hidden " ファイル編集中でもバッファを切り替えれるようにする
set history=100
set hlsearch " 検索結果のハイライト
set incsearch " 1文字入力ごとに検索を行う
set colorcolumn=80,130
set laststatus=2
set list
set listchars=tab:»·,trail:·,extends:»,precedes:«,nbsp:%
set number " 行番号表示
set numberwidth=5
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から行頭への移動
set cursorline " カーソルラインのハイライト
set scrolloff=5
set shiftwidth=2
set expandtab
set smartindent " 自動インデント
set autoindent
set nobackup
set noswapfile " スワップファイルを作らない
set showmatch " 対応括弧をハイライト表示する
set matchtime=2 " 対応括弧の表示秒数を3秒にする
set matchpairs& matchpairs+=<:> " 対応括弧に<と>のペアを追加
set nowritebackup
set lazyredraw " マクロなどの途中経過を描画しない
set loadplugins
set showcmd
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set splitright
set softtabstop=2
set synmaxcol=200 " 一行が200文字以上の場合は解析しないようにする
set tabstop=2
set ttimeoutlen=50
set wildmenu
set wrap
set mouse=a
set ttyfast " スクロールが遅い問題の解決
set virtualedit+=block " 短形選択を行末を超えて選択できるようになる
set cindent " indent type
set clipboard=unnamed " OSのクリップボードと共有
if has('gui_running')
  set guioptions-=r   " remove right scroll-bar (macvim)
  set macligatures
  set guifont=Fira\ Code\ Retina:h12
endif
"}}}

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Ignore images and log files
set wildignore+=*.gif,*.jpg,*.png,*.log
" Ignore bundle and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable OS X index files
set wildignore+=.DS_Store

" ヤンクレジスタに格納されるコマンド
let g:yankring_n_keys = 'Y y D'

let g:indentLine_faster = 1

let g:user_emmet_leader_key='<c-y>'

let g:vim_json_syntax_conceal = 0

let g:fern_disable_startup_warnings = 1

"}}}

" 自動コマンド{{{
augroup debugger_highlight
  autocmd!
  autocmd BufEnter *.ex syn match Error "IO.puts\|IO.inspect"
  autocmd BufEnter *.rb syn match Error "binding.pry\|debugger"
  autocmd BufEnter *.{js,coffee} syn match Error "console.log"
augroup END

augroup auto_save
  autocmd!
  autocmd BufLeave,FocusLost * silent! update
augroup END

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup reload_vim
  autocmd!
  autocmd BufWritePost *.vim source %
augroup END

augroup commit_width
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END

" カーソルのハイライトをlazyに
augroup cursorline_highlight
  let s:cur_f = 0
  autocmd WinEnter * setlocal cursorline | let s:cur_f = 0
  autocmd WinLeave * setlocal nocursorline
  autocmd CursorHold,CursorHoldI * setlocal cursorline | let s:cur_f = 1
  autocmd CursorMoved,CursorMovedI * if s:cur_f | setlocal nocursorline | endif
augroup END

" Fernの設定
function! s:init_fern() abort
  noremap <buffer> <Plug>(fern-action-hidden-set) <Plug>(fern-action-open)
endfunction

augroup fern_setting
  autocmd!
  " autocmd FileType * nested Fern . -reveal=% -drawer
  autocmd FileType fern call s:init_fern()
augroup END

" mapping設定{{{
" トグルでコメント制御
noremap ,. :TComment<CR>
noremap ., :TComment<CR>

" TABにて対応ペアにジャンプ
noremap <Tab> %

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
noremap j gj
noremap k gk

" ハイライトを消す(esc esc)
nnoremap <silent> <Esc><Esc> :noh<CR>

" xでヤンクレジスタに格納しない
nnoremap x "_x

" 1つ前のバッファに切り替え
nnoremap <silent> <C-J> :bprev<CR>
" 1つ後のバッファに切り替え
nnoremap <silent> <C-K> :bnext<CR>

nnoremap <silent> [w <Plug>(ale_previous)
nnoremap <silent> ]w <Plug>(ale_next)

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

nnoremap <silent> <C-b> :call fzf#run({
  \   'source':  reverse(<sid>buflist()),
  \   'sink':    function('<sid>bufopen'),
  \   'options': '+m',
  \   'down':    len(<sid>buflist()) + 2
  \ })<CR>

nnoremap Q <Nop>
nnoremap q: :q
nnoremap :Q :q

nnoremap <silent> <C-p> :FZF<CR>

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>
inoremap <silent> kk <ESC>

" 1つ前のバッファに切り替え
inoremap <silent> <C-J> <C-o>:bprev<CR>
" 1つ後のバッファに切り替え
inoremap <silent> <C-K> <C-o>:bnext<CR>

" insert mode中にemacsのキーバインドを流用
inoremap <C-a> <C-o>I
inoremap <C-e> <End>

" vを二回で行末まで選択
vnoremap v $h

vnoremap <silent> <Enter> :EasyAlign<cr>

syntax sync fromstart

" Local configure
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

" vimrcの最後にすべき設定
filetype plugin indent on
set t_Co=256
syntax on
set termguicolors
" set background=dark
colorscheme default  " delek, torte, desert
