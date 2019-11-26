set encoding=utf-8
scriptencoding utf-8
filetype off

" Init:
" Release autogroup in MyAutoCmd.
augroup MyyAutoCmd
  autocmd!
augroup END

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

" Use minpac.{{{
set packpath^=$CACHE_HOME
let s:package_home = $CACHE_HOME . '/pack/packages'
let s:minpac_dir = s:package_home . '/opt/minpac'
let s:minpac_download = 0
if has('vim_starting')
  if !isdirectory(s:minpac_dir)
    echo 'Install minpac ...'
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    let s:minpac_download = 1
  endif
endif

" minpac init.
let s:plugins = []
function! PackInit() abort"
  packadd minpac
  call minpac#init({'dir': $CACHE_HOME, 'package_name': 'packages'})
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  for plugin in s:plugins
    call minpac#add(plugin[0], plugin[1])
  endfor
endfunction
"}}}

" minpac helper function. {{{
let s:lazy_plugs = []
function! s:minpac_add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  if has_key(l:opts, 'if')
    if ! l:opts.if
      return
    endif
  endif

  let l:name = substitute(a:repo, '^.*/', '', '')

  " packadd on filetype.
  if has_key(l:opts, 'ft')
    let l:ft = type(l:opts.ft) == type([]) ? join(l:opts.ft, ',') : l:opts.ft
    exe printf('au MyAutoCmd FileType %s packadd %s', l:ft, l:name)
  endif

  " packadd on cmd.
  if has_key(l:opts, 'cmd')
    let l:cmd = type(l:opts.cmd) == type([]) ? join(l:opts.cmd, ',') : l:opts.cmd
    exe printf('au MyAutoCmd CmdUndefined %s packadd %s', l:cmd, l:name)
  endif

  if has_key(l:opts, 'lazy')
    if l:opts.lazy
      call add(s:lazy_plugs, l:name)
    endif
  endif

  call add(s:plugins, [a:repo, l:opts])
endfunction
"}}}

com! -nargs=+ Pac call <SID>minpac_add(<args>)

" Load lazy plugins.
let s:idx = 0
function! PackAddHandler(timer)
  exe 'packadd ' . s:lazy_plugs[s:idx]
  let s:idx += 1
  " doautocmd BufReadPost
  au! lazy_load_bundle
  if s:idx == len(s:lazy_plugs)
    echom 'lazy load done !'
  endif
endfunction

" Plugin settings.
source $VIM_PATH/start.vim
" source $VIM_PATH/opt.vim
source $VIM_PATH/lazy.vim

" Define user commands for updating/cleaning the plugins.{{{
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
com! PackClean     call PackInit() | call minpac#clean()
com! PackUpdate    call PackInit() | call minpac#clean() | call minpac#update() | call minpac#status()
com! PackListStart call PackInit() | Capture echo minpac#getpackages("", "start")
com! PackListOpt   call PackInit() | Capture echo minpac#getpackages("", "opt")
com! PackNameStart call PackInit() | Capture echo minpac#getpackages("", "start", "", 1)
com! PackNameOpt   call PackInit() | Capture echo minpac#getpackages("", "opt", "", 1)
" Quit Vim immediately after all updates are finished.
com! PackUpdateQuit call PackInit() | call minpac#update('', {'do': 'quit'})

" Install on initiall setup.
if s:minpac_download
  PackUpdate
endif
"}}}

" Set options.{{{1
set backspace=indent,eol,start " http://vim.wikia.com/wiki/Backspace_and_delete_problems
set fileencoding=utf-8
set hidden " ファイル編集中でもバッファを切り替えれるようにする
set history=1000
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
set scrolloff=6
set shiftwidth=2
set expandtab
set smartindent " 自動インデント
set autoindent
set nobackup
set noswapfile " スワップファイルを作らない
set showmatch " 対応括弧をハイライト表示する
set matchtime=3 " 対応括弧の表示秒数を3秒にする
set matchpairs& matchpairs+=<:> " 対応括弧に<と>のペアを追加
set nowritebackup
set lazyredraw " マクロなどの途中経過を描画しない
set loadplugins
set showcmd
set spell
set splitright
set softtabstop=2
set synmaxcol=200 " 一行が200文字以上の場合は解析しないようにする
set tabstop=2
set textwidth=80
set ttimeoutlen=50
set wildmenu "{{{
" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Ignore images and log files
set wildignore+=*.gif,*.jpg,*.png,*.log
" Ignore bundle and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable OS X index files
set wildignore+=.DS_Store
"}}}
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
"1}}}

" オリジナルの設定{{{
" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>

" ハイライトを消す
nnoremap <silent> <Esc><Esc> :noh<CR>

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" 1つ前のバッファに切り替え
nnoremap <silent> <C-j> :bprev<CR>
" 1つ後のバッファに切り替え
nnoremap <silent> <C-k> :bnext<CR>

vnoremap <silent> <Enter> :EasyAlign<cr>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

let g:indent_guides_enable_on_vim_startup = 0

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

augroup reload_vue_every_time
  autocmd!
  autocmd FileType vue syntax sync fromstart
  autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
augroup END

augroup commit_width
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END

" move windows with hjkl
nnoremap <silent> <C-H> :wincmd h<CR>
nnoremap <silent> <C-J> :wincmd j<CR>
nnoremap <silent> <C-K> :wincmd k<CR>
nnoremap <silent> <C-L> :wincmd l<CR>

noremap Q <Nop>
noremap q: :q
noremap ; :

map ,. :TComment<CR>
map ., :TComment<CR>
"}}}

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
colorscheme molokai
