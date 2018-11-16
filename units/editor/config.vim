" Add spaces after comment delimiters by default
let g:NERDSpaceDelims=1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

nnoremap <C-\/> :NERDComToggleComment<cr>

" easymotion {{{
" map <Leader><Leader> <Plug>(easymotion-prefix)
map <Leader>ll <Plug>(easymotion-lineforward)
map <Leader>jj <Plug>(easymotion-j)
map <Leader>kk <Plug>(easymotion-k)
map <Leader>hh <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" nmap s <Plug>(easymotion-s2)

" Move to word
map  <Leader>ww <Plug>(easymotion-bd-w)
nmap <Leader>ww <Plug>(easymotion-overwin-w)
" }}}

" {{{ tagbar
let g:tagbar_iconchars = ['*', '~']
nnoremap <F3> :TagbarToggle<CR>
nnoremap <leader>tb :TagbarToggle<CR>
" Jump to Tagbar window if already open
nnoremap <leader>tj :TagbarOpen j<CR>
" Close the Tagbar window if it is open
nnoremap <leader>tc :TagbarClose<CR>
" }}}

" {{{ NERDTree
let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeDirArrowExpandable = '*'
let g:NERDTreeDirArrowCollapsible = '~'
let g:NERDTreeIgnore=[
    \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$',
    \ '^\.hg$', '^\.svn$', '\.bzr$',
    \ ]
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <F4> :NERDTreeToggle<CR>
nnoremap <Leader>ft :NERDTreeToggle<CR>
nnoremap <Leader>fd :NERDTreeFind<CR>
" }}}

" {{{ vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" {{{ indentLine
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#504945'
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)
let g:indentLine_char = '|'
let g:indentLine_enabled = 0
" }}}

" {{{ vim-textobj-user
function! CurrentLineA()
  normal! 0
  let head_pos = getpos('.')
  normal! $
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! CurrentLineI()
  normal! ^
  let head_pos = getpos('.')
  normal! g_
  let tail_pos = getpos('.')
  let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
  return
  \ non_blank_char_exists_p
  \ ? ['v', head_pos, tail_pos]
  \ : 0
endfunction

call textobj#user#plugin('line', {
\   '-': {
\     'select-a-function': 'CurrentLineA',
\     'select-a': 'al',
\     'select-i-function': 'CurrentLineI',
\     'select-i': 'il',
\   },
\ })

" }}}

" {{{ AsyncRun
nnoremap <Leader>ar :AsyncRun<Space>
let g:asyncrun_open = 10
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
nnoremap <F10> :call asyncrun#quickfix_toggle(6) <CR>

function! s:def_command()
  command! -bang -nargs=0 Cmake
    \ :AsyncRun -cwd=<root> cmake . <CR>

  command! -bang -nargs=0 Run 
    \ :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<CR>

  command! -bang -nargs=0 MakeTest
    \ :AsyncRun -cwd=<root> -raw make test <CR>

  command! -bang -nargs=0 Make
    \ :AsyncRun -cwd=<root> -raw make <CR>

  command! -bang -nargs=0 MakeRun
    \ :AsyncRun -cwd=<root> -raw make run <CR>

  command! -bang -nargs=0 Build
    \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<CR>

endfunc

autocmd FileType c,cpp call s:def_command()

" }}}

" {{{ undotree
nnoremap <Leader>ut :MundoToggle<CR>
let g:mundo_width = 40
let g:mundo_preview_height = 30
let g:mundo_right = 1
let g:mundo_tree_statusline = "undo tree"
" }}}
