" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8
let g:lbvim_version = '0.6-dev'
let g:lbvim_isnvim = has('nvim')
let g:MAC = has('macunix')
let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = has('win32') || has('win64')

let g:lbvim_home = g:lbvim_isnvim ? $HOME . '/.config/nvim/' : $HOME . '/.vim/'
let g:lbvim_plug_home = g:lbvim_home . 'plugged/'
let g:lbvim_plug_path = g:lbvim_home . 'autoload/plug.vim'
" let g:lbvim_plug_home = g:lbvim_isnvim ? $HOME . '/.config/nvim/plugged/' : $HOME . '/.vim/plugged/'
" let g:lbvim_plug_path = g:lbvim_isnvim ? $HOME . '/.config/nvim/autoload/plug.vim' : $HOME . '/.vim/autoload/plug.vim'

if g:WINDOWS
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
set runtimepath+=$HOME/.vim/core

call core#begin()

Component 'better'
Component 'completor'
Component 'startify'
Component 'editor'
Component 'tags'
Component 'fzf'
Component 'theme'

call core#end()
