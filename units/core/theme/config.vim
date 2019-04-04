"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:37:45
"
"======================================================================

" {{{ color mode 
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if g:lbvim.tmux
  if g:lbvim.nvim
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if g:lbvim.termguicolors
    " fix bug for vim
    if !g:lbvim.nvim
      set t_8f=^[[38;2;%lu;%lu;%lum
      set t_8b=^[[48;2;%lu;%lu;%lum
    endif
    set termguicolors
  else
    set t_Co=256
  endif

  if &ttimeoutlen > 60 || &ttimeoutlen <= 0
    set ttimeoutlen=60
  endif
else
  set ttimeoutlen=20
endif
" }}}

" {{{ lightline & tabline

function! s:SID()
  if ! exists('s:sid')
    let s:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
  endif
  return s:sid
endfunction
let s:SNR = '<SNR>'.s:SID().'_'

function! s:LightlineFilename()
  return &filetype      ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype     ==# 'unite' ? unite#get_status_string() :
        \ &filetype     ==# 'vimshell' ? vimshell#get_status_string() :
        \ &filetype     ==# 'startify' ? 'startify' :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': s:SNR . 'LightlineFilename'
      \ },
      \ }

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#modified     = '*'
let g:lightline.tabline                 = {'left': [['buffers']], 'right': [[]]}
let g:lightline.separator               = {'left': "\ue0b1", 'right': "\ue0b3"}
let g:lightline.subseparator            = {'left': "\ue0b1", 'right': "\ue0b3"}
let g:lightline.component_expand        = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type          = {'buffers': 'tabsel'}
silent! set laststatus=2   " 总是显示状态栏

silent! set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
nmap <silent> <expr> <Leader>1 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"
nmap <silent> <expr> <Leader>2 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"
nmap <silent> <expr> <Leader>3 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"
nmap <silent> <expr> <Leader>4 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"
nmap <silent> <expr> <Leader>5 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"
nmap <silent> <expr> <Leader>6 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"
nmap <silent> <expr> <Leader>7 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"
nmap <silent> <expr> <Leader>8 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"
nmap <silent> <expr> <Leader>9 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"
nmap <silent> <expr> <Leader>0 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"
""" }}}

" {{{ theme
syntax on
set background=dark
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_termcolors = 256
let g:gruvbox_invert_indent_guides=1
let g:gruvbox_improved_strings = 1
colorscheme gruvbox
" let g:seoul256_background = 236
" colorscheme seoul256
" }}}

"{{{ startify
let g:startify_custom_header = [
                            \'      ┬  ┬┬ ┬┌┐ ┌─┐┌┐┌┌─┐ ',
                            \'      │  ││ │├┴┐├─┤││││ ┬ ',
                            \'      ┴─┘┴└─┘└─┘┴ ┴┘└┘└─┘ ',
                            \'                          ',
                            \'      Author: liubang <it.liubang@gmail.com> ',
                            \'        Site: https://iliubang.cn            ',
                            \'     Version: ' . g:lbvim.version,
                            \ ]

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]

let g:startify_change_to_vcs_root = 1
" }}}

"{{{ default
" 总是显示行号
set number
set showbreak=↪
set fillchars=vert:│,fold:─
set list
set listchars=tab:\|\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·
" Show trailing white space
" hi ExtraWhitespace guifg=#FF2626 gui=underline ctermfg=124 cterm=underline
" match ExtraWhitespace /\s\+$/
"}}}

