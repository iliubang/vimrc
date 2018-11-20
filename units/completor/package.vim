"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:00:25
"
"======================================================================

if !g:lbvim_isnvim
  MMP 'Shougo/deoplete.nvim', { 'do': ':UpdateRemoteMMPins' }
  MMP 'roxma/nvim-yarp'
  MMP 'roxma/vim-hug-neovim-rpc'
else
  MMP 'Shougo/deoplete.nvim'
endif

MMP 'ervandew/supertab'
MMP 'SirVer/ultisnips'
MMP 'iliubang/vim-snippets'

" for viml
MMP 'Shougo/neco-vim', { 'for': 'vim' }
