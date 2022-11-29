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

if [ -d $HOME/.config/karabiner ]; then
  ln -s $PWD/fn-hjkl-arrow-keys.json $HOME/.config/karabiner/assets/complex_modifications
fi
if !(type "cargo" > /dev/null 2>&1); then
  curl https://sh.rustup.rs -sSf | sh
fi

# ignore fish
# ln -s $PWD/.config/fish/config.fish $HOME/.config/fish/config.fish
# ln -s $PWD/.config/fish/fish_plugins $HOME/.config/fish/fish_plugins

# pip3 install --upgrade pynvim

# for d2 install
# curl -fsSL https://d2lang.com/install.sh | sh -s --
