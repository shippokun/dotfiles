" deoplete.{{{
Pac 'Shougo/deoplete.nvim', {'type': 'opt', 'lazy': 1}
let g:deoplete#enable_at_startup = 1
Pac 'roxma/nvim-yarp', {'type': 'opt', 'lazy': 1}
Pac 'roxma/vim-hug-neovim-rpc', {'type': 'opt', 'lazy': 1}
Pac 'prabirshrestha/async.vim', {'type': 'opt', 'lazy': 1}
"}}}

" For frontend plugins
Pac 'prettier/vim-prettier', { 'do': '!npm install', 'type': 'opt', 'lazy': 1}
Pac 'mattn/emmet-vim', {'type': 'opt', 'lazy': 1}

" syntax
Pac 'ap/vim-css-color', {'type': 'opt', 'lazy': 1}
Pac 'plasticboy/vim-markdown', {'type': 'opt', 'lazy': 1}
"{{{
let g:vim_markdown_fenced_languages = [
\ 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'ruby=rb', 'python=py',
\ 'markdown=md', 'javascript=js', 'elixir=elixir']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
"}}}
Pac 'posva/vim-vue', {'type': 'opt', 'lazy': 1}
Pac 'rust-lang/rust.vim', {'type': 'opt', 'lazy': 1}
Pac 'tpope/vim-rails', {'type': 'opt', 'lazy': 1}
Pac 'vim-ruby/vim-ruby', {'type': 'opt', 'lazy': 1}

" LSP(Language Server Protocol
Pac 'neoclide/coc.nvim', {'branch': 'release', 'type': 'opt', 'lazy': 1}

" hobby
Pac 'twitvim/twitvim', {'type': 'opt', 'lazy': 1}
let twitvim_enable_python = 1 "{{{
let twitvim_browser_cmd = 'chrm'
let twitvim_force_ssl = 1
let twitvim_count = 40
"}}}

" other settings.{{{
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 0
" adding the custom source to unite
let g:webdevicons_enable_unite = 0
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
