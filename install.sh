#!/bin/bash

if [ ! -x "`which fzf`" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".zplugin" ]] && continue

  echo "$f"
  ln -s $PWD/"$f" $HOME/"$f"
done

if [ -d $HOME/.config/karabiner ]; then
  ln -s $PWD/fn-hjkl-arrow-keys.json $HOME/.config/karabiner/assets/complex_modifications
fi
if !(type "cargo" > /dev/null 2>&1); then
  curl https://sh.rustup.rs -sSf | sh
fi

# pip3 install --upgrade pynvim
