#!/bin/bash

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".zplugin" ]] && continue
  [[ "$f" == ".config" ]] && continue
  [[ "$f" == ".trash" ]] && continue

  echo "$f"
  ln -s $PWD/"$f" $HOME/"$f"
done

if !(type "cargo" > /dev/null 2>&1); then
  curl https://sh.rustup.rs -sSf | sh
fi

