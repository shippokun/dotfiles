set encoding=utf-8
scriptencoding utf-8
set notcompatible
filetype off

" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})


