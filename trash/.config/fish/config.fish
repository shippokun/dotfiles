## PATH

# Homebrew
set -x PATH /opt/homebrew/bin:/usr/local/bin $PATH

## EDITOR
set -x EDITOR vim

## THEME
set -g theme_svn_prompt_enabled yes

## LANGUAGE
set -x LANG ja_JP.UTF-8

## ALIAS
alias la="ls -la"
alias v="vim"
alias t="tig"
alias g="git"
alias ls="ls -G"
alias ll="ls -lh"
alias l="exa -lT"
alias cl="clear"
alias mkdir="mkdir -p"
alias chrm="open /Applications/Google\ Chrome.app"
alias gpom="git pull origin master"
alias gplo="git pull origin"
alias vimrc="vim ~/.vimrc"
alias tigrc="vim ~/.tigrc"
alias fishrc="vim ~/.config/fish/config.fish"
# 不要なファイルを表示しない
alias tree='tree -a -I "\.DS_Store|\.git|node_modules|vendor\/bundle" -N'
# alias local_refresh="git branch --merged master | grep -vE '^\*|master$|staging$|production$' | xargs -I % git branch -d %"
# alias remote_refresh="git branch -r --merged master | grep -v -e master -e staging -e production | sed -e 's% *origin/%%' | xargs -I% git push --delete origin %"

## KEY_BINDINGS

function fish_user_key_bindings
    bind \co __fzf_open --editor
    bind \cr __fzf_reverse_isearch
    bind \c] __ghq_repository_search
    bind \cb __fzf_select_branch
end

## OPTIONS
function fzf
    command fzf --height 30% --reverse --border $argv
end

## asdf
source /usr/local/opt/asdf/asdf.fish

export PATH="/usr/local/opt/openssl/bin:$PATH"
