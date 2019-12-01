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

if exists('*minpac#init')"{{{1
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Add about vim plugins
  call minpac#add('Townk/vim-autoclose')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('honza/vim-snippets')
  call minpac#add('ntpeters/vim-better-whitespace')
  call minpac#add('terryma/vim-multiple-cursors')
  call minpac#add('tomtom/tcomment_vim')
  call minpac#add('tpope/vim-surround')
  call minpac#add('junegunn/vim-easy-align')

  " For frontend plugins
  call minpac#add('prettier/vim-prettier', { 'do': '!npm install' })
  call minpac#add('mattn/emmet-vim')

  " Syntax
  call minpac#add('ap/vim-css-color')
  call minpac#add('plasticboy/vim-markdown')
  call minpac#add('posva/vim-vue')
  call minpac#add('rust-lang/rust.vim')

  " LSP(Language Server Protocol)
  call minpac#add('neoclide/coc.nvim', {'branch': 'release', 'opt': 'lazy'})

  " Hobby
  call minpac#add('twitvim/twitvim') "{{{2
  let twitvim_enable_python = 1
  let twitvim_browser_cmd = 'chrm'
  let twitvim_force_ssl = 1
  let twitvim_count = 40
  "}}}
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
set scrolloff=10
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
set wildmenu
set wrap
set mouse=a
set ttyfast " スクロールが遅い問題の解決
set virtualedit+=block " 短形選択を行末を超えて選択できるようになる
set cindent " indent type
set clipboard=unnamed " OSのクリップボードと共有
if has("gui_running")
  set guioptions-=r   " remove right scroll-bar (macvim)
  set macligatures
  set guifont=Fira\ Code\ Retina:h12
endif
"}}}

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

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Ignore images and log files
set wildignore+=*.gif,*.jpg,*.png,*.log

" Ignore bundle and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable OS X index files
set wildignore+=.DS_Store

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let g:vim_markdown_fenced_languages = [
\ 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'ruby=rb', 'python=py',
\ 'markdown=md', 'javascript=js', 'elixir=elixir']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

let g:indentLine_faster = 1

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

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

augroup reload_vue_every_time
  autocmd!
  autocmd FileType vue syntax sync fromstart
  autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
augroup END

augroup commit_width
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END

" 折り畳み機能を有効化
augroup folding_enable
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  set foldtext=getline(v:foldstart)
  set fillchars=fold:\ " white spaceは態と残している
  autocmd Colorscheme * hi Folded ctermfg=lightmagenta guifg=lightmagenta
augroup END
"}}}

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
