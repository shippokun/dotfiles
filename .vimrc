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

" Init minpac.{{{
if exists('*minpac#init')
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
  call minpac#add('w0rp/ale')
  call minpac#add('Yggdroot/indentLine')
  call minpac#add('tpope/vim-projectionist')
  call minpac#add('deris/vim-shot-f')
  call minpac#add('mattn/vim-sqlfmt')
  call minpac#add('lambdalisue/fern.vim')
  call minpac#add('editorconfig/editorconfig-vim')

  " For frontend plugins
  call minpac#add('prettier/vim-prettier', { 'do': '!npm install' })
  call minpac#add('mattn/emmet-vim')

  " For deoplete
  call minpac#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call minpac#add('roxma/nvim-yarp')
    call minpac#add('roxma/vim-hug-neovim-rpc')
  endif
  call minpac#add('Shougo/neosnippet.vim')
  call minpac#add('Shougo/neosnippet-snippets')

  " Style
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('ryanoasis/vim-devicons')
  call minpac#add('rafi/awesome-vim-colorschemes')

  " Syntax
  call minpac#add('ap/vim-css-color')
  call minpac#add('posva/vim-vue')
  call minpac#add('rust-lang/rust.vim')

  " LSP(Language Server Protocol)
  call minpac#add('prabirshrestha/async.vim')
  call minpac#add('prabirshrestha/asyncomplete.vim')
  call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
  call minpac#add('prabirshrestha/vim-lsp')
  call minpac#add('mattn/vim-lsp-settings')

  " Hobby
  call minpac#add('twitvim/twitvim')
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

" for deoplete.nvim
let g:deoplete#enable_at_startup = 1

let g:LanguageClient_serverCommands = {
\ 'vue': ['vls']
\ }

let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\}

let g:ale_fix_on_save = 1
let g:ale_sign_error = "\uF05E"
let g:ale_sign_warning = "\uF071"

let twitvim_enable_python = 1
let twitvim_browser_cmd = 'chrm'
let twitvim_force_ssl = 1
let twitvim_count = 40

" airline options{{{
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 0
" adding the custom source to unite
let g:webdevicons_enable_unite = 0
" adding the column to vimfiler
let g:webdevicons_enable_vimfiler = 0
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
" ctrlp glyphs
let g:webdevicons_enable_ctrlp = 0
" adding to flagship's statusline
let g:webdevicons_enable_flagship_statusline = 0
" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1
" use double-width(1) or single-width(0) glyphs
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1
" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0

let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.paste = "\uf0ea"
let g:airline_symbols.readonly = "\ue0a2"
let g:airline_symbols.modified = "\uf459"
let g:airline_symbols.spell = "\uf49e"
let g:airline_symbols.branch = "\uf418"
let g:airline_section_x = ''
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

augroup reload_vue_every_time
  autocmd!
  autocmd FileType vue syntax sync fromstart
  autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
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

" 折り畳み機能を有効化
augroup folding_enable
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  set foldtext=getline(v:foldstart)
  set fillchars=fold:\ " white spaceは態と残している
  autocmd Colorscheme * hi Folded ctermfg=lightmagenta guifg=lightmagenta
augroup END

" htmlの閉じタグ補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
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
"}}}

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
" Start interactive EasyAlign in visual mode (e.g. vipga)
vnoremap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

vnoremap <Enter> <Plug>(EasyAlign)
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
set background=dark
colorscheme desert "hybrid, delek, torte, desert
