" Add about vim plugins
Pac 'Townk/vim-autoclose'
Pac 'airblade/vim-gitgutter'
Pac 'honza/vim-snippets'
Pac 'nathanaelkane/vim-indent-guides'
Pac 'ntpeters/vim-better-whitespace'
Pac 'terryma/vim-multiple-cursors', {'type': 'opt'}
Pac 'tomtom/tcomment_vim'
Pac 'tpope/vim-surround'
Pac 'junegunn/vim-easy-align'
Pac 'Yggdroot/indentLine'
Pac 'w0rp/ale'
" ale configs {{{
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
"}}}

" 折り畳み機能を有効化
au FileType vim setlocal foldmethod=marker
set foldtext=getline(v:foldstart)
set fillchars=fold:\
au Colorscheme * hi Folded ctermfg=lightmagenta guifg=lightmagenta
