# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Clone zinit if not exist
if [[ ! -d ~/.zinit ]]; then
  git clone https://github.com/zdharma/zinit $HOME/.zinit/bin
fi

export PATH="$HOME/.cargo/bin:$PATH"

source $HOME/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# 構文のハイライト
zinit ice wait'!0'; zinit load zdharma/fast-syntax-highlighting
zinit ice depth=1; zinit light romkatv/powerlevel10k
# タイプ補完
zinit load zsh-users/zsh-autosuggestions
zinit ice wait'!0'; zinit load zsh-users/zsh-syntax-highlighting # 実行可能なコマンドに色付け
zinit ice wait'!0'; zinit load zsh-users/zsh-completions
# cdコマンド強化用プラグイン
zinit ice wait'!0'; zinit load b4b4r07/enhancd
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

# if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
#   alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
# fi

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
alias dc="docker-compose"
alias ngc="npx git-cz"

# 不要なファイルを表示しない
alias tree='tree -a -I "\.DS_Store|\.git|node_modules|vendor\/bundle" -N'

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

eval "$(direnv hook zsh)"

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!**/.DS_Store" --glob "!**/node_modules/*" --glob "!vendor/*" 2> /dev/null'
export FZF_DEFAULT_OPTS='--inline-info --height 40% --border'

load_if_exists "$HOME/.zshrc.local"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
