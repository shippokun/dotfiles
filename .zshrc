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
setopt share_history # ヒストリの共有の有効化
setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_all_dups # ヒストリに追加されるコマンドが古いものと同じなら古いものを削除
setopt append_history # 複数のzshを同時に使う時などhistoryファイルを上書きせずに追加
setopt auto_menu # タブキーの連打で自動的にメニュー補完
setopt auto_cd # cdを使わずにディレクトリを移動できる
setopt auto_pushd # "cd -"の段階でTabを押すと、ディレクトリの履歴が見れる
setopt correct # コマンドの打ち間違いを指摘してくれる
setopt rm_star_wait # rm *で確認
LISTMAX=1000 # 補完リストが多いときは尋ねない
WORDCHARS="$WORDCHARS|:" # "|,:"を単語の一部とみなさない
autoload history-search-end #入力途中の履歴補完を有効化する
setopt no_promptcr # 改行コードで終らない出力もちゃんと出力する
setopt no_beep # 補完候補がないときにビープ音を鳴らさない
setopt HIST_REDUCE_BLANKS   # 余分な空白は詰めて記録

if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
  alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
fi

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
alias tigrc="vim ~/.tigrc"
alias v="vim"
alias g="git"

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

load_if_exists () {
  if [ -e $1 ]; then
    source $1
  fi
}

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!**/.DS_Store" --glob "!**/node_modules/*" --glob "!vendor/*" 2> /dev/null'
export FZF_DEFAULT_OPTS='--inline-info --height 40% --border'

load_if_exists "$HOME/.zshrc.local"

