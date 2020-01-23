"======================================================================
"
" plugins.vim - 
"
" Created by liubang on 2020/01/21
" Last Modified: 2020/01/21 16:29
"
"======================================================================

" {{{ ui
call dein#add('ryanoasis/vim-devicons')
call dein#add('sainnhe/gruvbox-material', {'rev': 'neosyn'})
call dein#add('hardcoreplayers/spaceline.vim', {'depends': 'vim-devicons'})
call dein#add('mhinz/vim-startify', {'depends': 'vim-devicons'})
call dein#add('bagrat/vim-buffet', {'depends': 'vim-devicons'})
" }}}

" {{{ tools
call dein#add('wsdjeg/dein-ui.vim')
call dein#add('Shougo/defx.nvim')
call dein#add('kristijanhusak/defx-icons', { 'depends': ['vim-devicons', 'defx.nvim'] })
call dein#add('kristijanhusak/defx-git', { 'depends': 'defx.nvim' })
call dein#add('tpope/vim-fugitive')
call dein#add('junegunn/vim-easy-align', { 'on_map': '<Plug>(EasyAlign)', 'on_cmd': 'EasyAlign' })
call dein#add('junegunn/fzf', {'build': './install --all', 'merged': 0})
call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})
call dein#add('dominikduda/vim_current_word')
call dein#add('terryma/vim-expand-region')
call dein#add('skywind3000/vim-quickui')
call dein#add('skywind3000/asyncrun.vim', {'on_cmd': ['AsyncRun', 'AsyncRun!']})
call dein#add('voldikss/vim-floaterm', {'on_cmd': ['FloatermToggle', 'FloatermNew']})
call dein#add('liuchengxu/vista.vim', {'on_cmd': ['Vista', 'Vista!', 'Vista!!']})
call dein#add('easymotion/vim-easymotion', {'on_map': [ 
      \ '<Plug>(easymotion-lineforward)',
      \ '<Plug>(easymotion-j)',
      \ '<Plug>(easymotion-k)',
      \ '<Plug>(easymotion-linebackward)',
      \ '<Plug>(easymotion-bd-w)',
      \ '<Plug>(easymotion-overwin-w)']})
call dein#add('Shougo/vinarise.vim', {'on_cmd': 'Vinarise'})
call dein#add('mg979/vim-visual-multi')
call dein#add('t9md/vim-choosewin', {'on_cmd': ['ChooseWin']})
call dein#add('tpope/vim-surround')
call dein#add('itchyny/calendar.vim', {'on_cmd': ['Calendar']})
call dein#add('preservim/nerdcommenter', {'on_map': [ 
      \ '<Plug>NERDCommenterComment',
      \ '<Plug>NERDCommenterNested',
      \ '<Plug>NERDCommenterToggle',
      \ '<Plug>NERDCommenterSexy',
      \ '<Plug>NERDCommenterToEOL',
      \ '<Plug>NERDCommenterUncomment',
      \ ]})
" }}}

" {{{ coder
call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
call dein#add('honza/vim-snippets')
call dein#add('neoclide/jsonc.vim', {'on_ft': ['json', 'jsonc']})

call dein#add('rhysd/vim-clang-format', {'on_ft': ['c', 'cpp', 'proto', 'objc']})
call dein#add('sakhnik/nvim-gdb', {'build': 'sh install.sh', 'on_ft': ['c', 'cpp']})
call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft': ['c', 'cpp', 'lex', 'yacc']})

call dein#add('fatih/vim-go', {'on_ft': ['go']})
call dein#add('StanAngeloff/php.vim', {'on_ft': ['php']})
call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'cd app & yarn install' })
" }}}
