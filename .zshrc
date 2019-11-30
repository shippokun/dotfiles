# Clone zplugin if not exist
if [[ ! -d ~/.zplugin ]]; then
  git clone https://github.com/zdharma/zplugin $HOME/.zplugin
fi

source $HOME/.zplugin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# 構文のハイライト
zplugin light zdharma/fast-syntax-highlighting
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
# タイプ補完
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-completions
zplugin light chrissicool/zsh-256color
# cdコマンド強化用プラグイン
zplugin light b4b4r07/enhancd
# 大文字小文字関係なく補完
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
# 補完候補を矢印でも選択可能に
zstyle ':completion:*:default' menu select=2

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# ヒストリの共有の有効化
setopt share_history
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
# ヒストリに追加されるコマンドが古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# 複数のzshを同時に使う時などhistoryファイルを上書きせずに追加
setopt append_history
#タブキーの連打で自動的にメニュー補完
setopt auto_menu
# cdを使わずにディレクトリを移動できる
setopt auto_cd
# "cd -"の段階でTabを押すと、ディレクトリの履歴が見れる
setopt auto_pushd
# コマンドの打ち間違いを指摘してくれる
setopt correct
# rm *で確認
setopt rm_star_wait
#  補完リストが多いときは尋ねない
LISTMAX=1000
# "|,:"を単語の一部とみなさない
WORDCHARS="$WORDCHARS|:"
#入力途中の履歴補完を有効化する
autoload history-search-end
# 改行コードで終らない出力もちゃんと出力する
setopt no_promptcr
# 補完候補がないときにビープ音を鳴らさない
setopt no_beep

alias ls="ls -G"
alias la="ls -a"
alias ll="ls -lh"
alias cl="clear"
alias mkdir="mkdir -p"
alias chrm="open /Applications/Google\ Chrome.app"
alias python="python3"
alias pip ="pip3"
alias l="exa -lT"
alias gpom="git pull origin master"
alias gplo="git pull origin"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"

autoload -U compinit
compinit

function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

eval "$(anyenv init -)"
export PATH="/usr/local/opt/libarchive/bin:$PATH"

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
