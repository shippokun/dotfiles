set encoding=utf-8
scriptencoding utf-8
let g:hybrid_use_iTerm_colors=1
colorscheme hybrid
set nocompatible
filetype off

" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Add about vim plugins
  call minpac#add('Townk/vim-autoclose', {'opt': 'lazy'})
  call minpac#add('airblade/vim-gitgutter', {'opt': 'lazy'})
  call minpac#add('honza/vim-snippets', {'opt': 'lazy'})
  call minpac#add('ntpeters/vim-better-whitespace', {'opt': 'lazy'})
  call minpac#add('terryma/vim-multiple-cursors', {'type': 'opt'})
  call minpac#add('tomtom/tcomment_vim', {'opt': 'lazy'})
  call minpac#add('tpope/vim-surround', {'opt': 'lazy'})
  call minpac#add('junegunn/vim-easy-align', {'opt': 'lazy'})

  " For frontend plugins
  call minpac#add('prettier/vim-prettier', { 'do': '!npm install' })
  call minpac#add('mattn/emmet-vim')

  " syntax
  call minpac#add('ap/vim-css-color', {'opt': 'lazy'})
  call minpac#add('plasticboy/vim-markdown', {'opt': 'lazy'})
  call minpac#add('posva/vim-vue', {'opt': 'lazy'})
  call minpac#add('rust-lang/rust.vim', {'opt': 'lazy'})
  call minpac#add('tpope/vim-rails', {'opt': 'lazy'})
  call minpac#add('vim-ruby/vim-ruby', {'opt': 'lazy'})

  " LSP(Language Server Protocol)
  call minpac#add('neoclide/coc.nvim', {'branch': 'release', 'opt': 'lazy'})
endif

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
packadd minpac

filetype on
filetype indent on
filetype plugin on
" ファイル名と内容によてファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype plugin indent on
syntax enable

set backspace=indent,eol,start " http://vim.wikia.com/wiki/Backspace_and_delete_problems
set encoding=utf-8  " Set encoding
set fileencoding=utf-8  " Set encoding
set hidden " ファイル編集中でもバッファを切り替えれるようにする
set history=100
set hlsearch " 検索結果のハイライト
set incsearch " 1文字入力ごとに検索を行う
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

" deopleteの設定
let g:deoplete#enable_at_startup = 1

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 0
" adding the custom source to unite
let g:webdevicons_enable_unite = 0
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1

let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'i'  : 'I',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ ' '  : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \  }

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.paste = "\uf0ea"
let g:airline_symbols.readonly = "\ue0a2"
let g:airline_symbols.modified = "\uf459"
let g:airline_symbols.spell = "\uf49e"
let g:airline_symbols.branch = "\uf418"
let g:airline_section_x = ''

let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'javascript': ['eslint', 'prettier'],
\   'markdown': ['mdl'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\   'vim': ['vlit'],
\}

let g:ale_fix_on_save = 1
let g:ale_sign_error = "\uF05E"
let g:ale_sign_warning = "\uF071"

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

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" let g:indent_guides_enable_on_vim_startup = 0

scriptencoding utf-8

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

syntax enable
syntax sync fromstart

" Local configure
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
