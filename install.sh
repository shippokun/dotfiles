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
