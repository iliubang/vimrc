"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:00:19
"
"======================================================================
if g:lbvim.tmux
  " {{{ defer#tmux
  MMP 'tmux-plugins/vim-tmux-focus-events', { 'on': [] }
  MMP 'roxma/vim-tmux-clipboard', { 'on': [], 'defer': {'delay': 600, 'callback': 'defer#tmux'} }
  " }}}
endif

" for viml
MMP 'Shougo/neco-vim', { 'for': 'vim' }
