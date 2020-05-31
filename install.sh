#!/bin/bash

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
# pip3 install --upgrade pynvim
