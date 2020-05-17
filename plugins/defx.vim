"======================================================================
"
" defx.vim - 
"
" Created by liubang on 2020/05/17
" Last Modified: 2020/05/17 18:54
"
"======================================================================

call defx#custom#option('_', {
      \ 'columns': 'indent:git:icons:filename',
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })
call defx#custom#column('filename', {
      \ 'min_width': 80,
      \ 'max_width': 80,
      \ })

function! s:defx_context_menu() abort
  let l:actions = ['new_multiple_files', 'rename', 'copy', 'move', 'paste', 'remove']
  let l:selection = confirm('Action?', "&New file/directory\n&Rename\n&Copy\n&Move\n&Paste\n&Delete")
  silent exe 'redraw'
  return feedkeys(defx#do_action(l:actions[l:selection - 1]))
endfunc

function! s:defx_toggle_tree() abort
  if defx#is_directory()
    return defx#do_action('open_or_close_tree')
  endif
  return defx#do_action('drop')
endfunc

function! s:defx_mappings() 
  setlocal nolist
  setlocal nonumber
  setlocal norelativenumber
  setlocal nofoldenable
  setlocal foldmethod=manual
  nnoremap <silent><buffer>m :call <SID>defx_context_menu()<CR>
  nnoremap <silent><buffer><expr> o <SID>defx_toggle_tree()
  nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
  " split open
  nnoremap <silent><buffer><expr> s defx#do_action('open', 'botright split')
  " vsplit open 
  nnoremap <silent><buffer><expr> v defx#do_action('open', 'botright vsplit')
  " refresh
  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
  " cd top one 
  nnoremap <silent><buffer><expr> U defx#async_action('multi', [['cd', '..'], 'change_vim_cwd'])
  " if is directory, then cd
  nnoremap <silent><buffer><expr> C defx#is_directory() ? defx#do_action('multi', ['open', 'change_vim_cwd']) : ''
  " cd ~/
  nnoremap <silent><buffer><expr> ~ defx#async_action('cd')
  " toggle ignore files
  nnoremap <silent><buffer><expr> H defx#do_action('toggle_ignored_files')
  " toggle select
  nnoremap <silent><buffer><expr> <C-k> defx#do_action('toggle_select') . 'k'
  nnoremap <silent><buffer><expr> <C-j> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> <C-a> defx#do_action('toggle_select_all')
  " move up or down
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  " copy path
  nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
  " quit
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
endfunc

augroup vfinit
  au!
  autocmd FileType defx call s:defx_mappings()
  autocmd FileType defx :let b:vim_current_word_disabled_in_this_buffer = 1
  " Move focus to the next window if current buffer is defx
  autocmd TabLeave * if &ft == 'defx' | wincmd w | endif
  " Close defx if it's the only buffer left in the window
  autocmd WinEnter * if &ft == 'defx' && winnr('$') == 1 | q | endif
augroup END
