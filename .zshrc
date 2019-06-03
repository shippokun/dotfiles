source $HOME/.zplugin/bin/zplugin.zsh
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

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

alias ls="ls -G"
alias la="ls -a"
alias ll="ls -lh"

autoload -U compinit
compinit
