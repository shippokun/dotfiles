" -- Syntax Highlighting ---------------------------------------
let g:hybrid_use_iTerm_colors = 1
colorscheme hybrid
syntax on

" tab幅の設定
set tabstop=2
set expandtab
set shiftwidth=2

" 連続した空白に対するカーソルの動く幅
set softtabstop=2

" 行番号の設定
set number
" スワップファイルを作らない
set noswapfile

" 自動インデント
set smartindent
set autoindent

" [検索]大文字小文字を区別しない
set ignorecase
set smartcase

" 1文字入力ごとに検索を行う
set incsearch
" 検索結果のハイライト
set hlsearch
" ハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" 保存時の文字コード
set fileencoding=utf-8
" 読み込み時の文字コードの自動判別、左優先
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
" 改行コードの自動判別、左優先
set fileformats=unix,dos,mac

" カーソルの左右移動で行末から行頭への移動
set whichwrap=b,s,h,l,<,>,[,],~
" カーソルラインのハイライト
set cursorline

"マウス操作の有効化
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

"コマンドモードの補完
set wildmenu

"保存するコマンド履歴の数
set history=5000

"クリップボードからコピペする際のインデントのズレを防ぐ
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
set clipboard=unnamedplus

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
inoremap ""  ""<left>
inoremap $$  $$<left>
inoremap ''  ''<left>
inoremap ()  ()<left>
inoremap <>  <><left>
inoremap []  []<left>
"

" 対応する括弧などをハイライト表示する
set showmatch
" 対応括弧のハイライト表示を3秒にする
set matchtime=3

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" 長いテキストの折り返し
set wrap
" 余裕を持ってスクロールs
set scrolloff=5

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %


