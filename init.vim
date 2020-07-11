"======================================================================
"
" init.vim - 
"
" Created by liubang on 2020/05/24
" Last Modified: 2020/05/24 10:54
"
"======================================================================
" vim: et ts=2 sts=2 sw=2

let g:nvg_version = 'v2.2'
let g:nvg_root = fnamemodify(resolve(expand('<sfile>:p')), ':h')

if !empty($PYTHON3_HOST_PROG)
  let g:python3_host_prog = $PYTHON3_HOST_PROG
elseif !empty($PYTHON_HOST_PROG)
  let g:python_host_prog = $PYTHON_HOST_PROG
endif

exec 'so '     .g:nvg_root . '/modules/default.vim'
exec 'so '     .g:nvg_root . '/modules/plugins.vim'
exec 'so '     .g:nvg_root . '/modules/ui.vim'
exec 'so '     .g:nvg_root . '/modules/utils.vim'
exec 'so '     .g:nvg_root . '/modules/fzf.vim'
exec 'so '     .g:nvg_root . '/modules/defx.vim'
exec 'so '     .g:nvg_root . '/modules/coc.vim'
exec 'so '     .g:nvg_root . '/modules/gtags.vim'
" exec 'so '     .g:nvg_root . '/modules/nvim-lsp.vim'
