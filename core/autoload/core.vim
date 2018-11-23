"======================================================================
"
" core.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:10:03
"
"======================================================================

" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

let g:dot_customfile = $HOME . '/.vim.custom'
let g:components_loaded = []

function! core#begin() abort
  if !g:IS_WINDOWS
    call s:check_vim_plug()
  endif
  call s:define_command()
  call s:check_custom_file()
endfunction

function! core#end() abort
  " regist all plugs
  call s:register_plugs()
  call s:register_configs()

  if exists('*CustomConfig')
    call CustomConfig()
  endif
endfunction

function! s:define_command()
  command! -nargs=+ -bar MMP call plug#(<args>)
  command! -nargs=+ -bar CM call s:component(<args>)
endfunction

function! s:component(name, ...)
  if index(g:components_loaded, a:name) == -1
    call add(g:components_loaded, a:name)
  endif
endfunction

function! s:register_plugs()
  call plug#begin(g:lbvim_plug_home)

  if exists('*CustomPlug')
    call CustomPlug()
  endif

  for l:component in g:components_loaded
    let l:component_package = g:components_dir . '/' . l:component . '/package.vim'
    try
      execute 'so ' . l:component_package
    catch
      return utils#err(v:exception, l:component_package)
    endtry
  endfor

  call plug#end()
  call s:check_custom_plug()
endfunction

function! s:register_configs()
  for l:component in g:components_loaded
    let l:component_config = g:components_dir . '/' . l:component . '/config.vim'
    try
      execute 'so ' . l:component_config
    catch
      return utils#err(v:exception, l:component_config)
    endtry
  endfor
endfunction

function! s:check_custom_file()
  if filereadable(expand(g:dot_customfile))
    execute 'so ' . g:dot_customfile
  endif
endfunction

function! s:check_vim_plug()
  if empty(glob(g:lbvim_plug_path))
    execute 'silent !curl -fLo ' . g:lbvim_plug_path . ' --create-dirs ' .
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endfunction

function! s:check_custom_plug()
  " https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
  augroup checkPlug
    autocmd!
    autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   echom 'Some plugins need to install the missing plugins first!'
      \|   PlugInstall --sync | q
      \| endif
  augroup END
endfunction
