" vim: et ts=2 sts=2 sw=2

" {{{ Defx
let g:defx_icons_enable_syntax_highlight = 1
call defx#custom#option('_', {
      \ 'columns': 'indent:git:icons:filename',
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': 'Defx_tree',
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

function s:defx_toggle_tree() abort
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
  nnoremap <silent><buffer>m :call <sid>defx_context_menu()<CR>
  nnoremap <silent><buffer><expr> o <sid>defx_toggle_tree()
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
  " Close defx if it's the only buffer left in the window
  autocmd FileType defx call s:defx_mappings()                                  "Defx mappings
  " Move focus to the next window if current buffer is defx
  autocmd TabLeave * if &ft == 'defx' | wincmd w | endif
  " Close defx if it's the only buffer left in the window
  autocmd WinEnter * if &ft == 'defx' && winnr('$') == 1 | q | endif
augroup END
nnoremap <silent><Leader>ft :Defx <CR>
" }}}

" {{{ fzf
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', '#3a3a3a'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
else
  let s:sname = expand('<sfile>')
  call utils#err("Please install ripgrep!", s:sname)
endif

function! s:files()
  let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
  return s:prepend_icon(l:files)
endfunc

function! s:prepend_icon(candidates)
  let l:result = []
  for l:candidate in a:candidates
    let l:filename = fnamemodify(l:candidate, ':p:t')
    let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
    call add(l:result, printf('%s %s', l:icon, l:candidate))
  endfor
  return l:result
endfunc

function! s:edit_file(item)
  let l:pos = stridx(a:item, ' ')
  let l:file_path = a:item[pos+1:-1]
  execute 'silent e' l:file_path
endfunc

" Files + devicons
function! s:fzf()
  let l:fzf_files_options = ''
  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink': function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down': '30%'})
endfunc

nmap <silent><Leader>? <plug>(fzf-maps-n)
xmap <silent><Leader>? <plug>(fzf-maps-x)
omap <silent><Leader>? <plug>(fzf-maps-o)

" https://github.com/junegunn/fzf/issues/453
nnoremap <silent> <expr> <Leader>ag (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Rg\<cr>"
" nnoremap <silent> <expr> <Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Buffer\<cr>"
nnoremap <silent> <expr> <Leader>w? (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Windows\<cr>"
nnoremap <silent> <expr> <Leader>f? (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Files ~\<cr>"
nnoremap <silent> <expr> <Leader>ht (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Helptags\<cr>"
nnoremap <silent> <expr> <C-p>      (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":call <sid>fzf()\<cr>"
" }}}

" {{{ vim_current_word
let g:vim_current_word#enabled = 1
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 0
let g:vim_current_word#highlight_only_in_focused_window = 1
autocmd FileType defx :let b:vim_current_word_disabled_in_this_buffer = 1
" }}}

" {{{ Vista
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'ctags'
let g:vista_icon_indent = [" ", " "]
let g:vista_echo_cursor = 0
let g:vista_fzf_preview = ['right:50%']
let g:vista_executive_for = {
  \ 'markdown': 'toc',
  \ 'vim': 'ctags',
  \ 'go': 'coc',
  \ 'c': 'coc',
  \ 'cpp': 'coc',
  \ 'javascript': 'coc',
  \ 'typescript': 'coc',
  \ }

" tab list
nnoremap <silent><leader><F3> :Vista!!<CR>
nnoremap <silent><leader>tl :Vista!!<CR>
nnoremap <silent><leader>vf :Vista finder coc<CR>
" }}}

" easymotion {{{
" map <Leader><Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
map <Leader>ll <Plug>(easymotion-lineforward)
map <Leader>jj <Plug>(easymotion-j)
map <Leader>kk <Plug>(easymotion-k)
map <Leader>hh <Plug>(easymotion-linebackward)

" Move to word
map  <Leader>ww <Plug>(easymotion-bd-w)
nmap <Leader>ww <Plug>(easymotion-overwin-w)
" }}}

" {{{ AsyncRun
let g:asyncrun_open = 15
let g:asyncrun_bell = 1
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
nnoremap <Leader>ar :AsyncRun<Space>

" for git
command! -bang -nargs=1 GitCommit
      \ :AsyncRun -cwd=<root> -raw git status && git add . && git commit -m <q-args> && git push origin

nnoremap <Leader>gc :GitCommit<Space>

function! s:async_build(args)
  if &filetype == 'c'
    if empty(a:args)
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw cc " . g:nvg.build.cflags . " $(VIM_FILEPATH) -o $(VIM_FILEDIR)/$(VIM_FILENOEXT)"
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw cc " . a:args . " $(VIM_FILEPATH) -o $(VIM_FILEDIR)/$(VIM_FILENOEXT)"
    endif
  elseif &filetype == 'cpp'
    if empty(a:args)
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw c++ " . g:nvg.build.cppflags . " $(VIM_FILEPATH) -o $(VIM_FILEDIR)/$(VIM_FILENOEXT)"
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw c++ " . a:args . " $(VIM_FILEPATH) -o $(VIM_FILEDIR)/$(VIM_FILENOEXT)"
    endif
  elseif &filetype == 'java'
    if empty(a:args)
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw javac ${VIM_FILEPATH}"
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw javac " . a:args . " $(VIM_FILEPATH)"
    endif
  elseif &filetype == 'go'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw go build " . a:args
  endif
endfunc

function! s:async_run(args)
  if &filetype == 'c' || &filetype == 'cpp'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw $(VIM_FILEDIR)/$(VIM_FILENOEXT) " . a:args
  elseif &filetype == 'php'
    if !executable('php')
      call utils#err("php is not executable", s:scriptname) 
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw php -f $(VIM_FILEPATH) " . a:args
    endif
  elseif &filetype == 'python'
    if !executable('python')
      call utils#err("python is not executable", s:scriptname)
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw python $(VIM_FILEPATH) " . a:args 
    endif
  elseif &filetype == 'java'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw java $(VIM_FILENOEXT)"
  elseif &filetype == 'sh'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw sh $(VIM_FILEPATH) " . a:args
  elseif &filetype == 'go'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw go run $(VIM_FILEPATH) " . a:args
  endif
endfunc

function! s:maven(opt, goal)
  if executable('mvn')
    execute "AsyncRun -cwd=<root> -raw mvn " . a:opt . " " . a:goal
  else
    call utils#err("mvn is not executable", s:scriptname)
  endif
endfunc

command! -bang -nargs=? Build call s:async_build(<q-args>)
command! -bang -nargs=? Run call s:async_run(<q-args>)
command! -bang -nargs=? Maven call s:maven(<q-args>, "")
command! -bang -nargs=? MavenSkip call s:maven("-Dmaven.test.skip", <q-args>)
command! -bang -nargs=? MavenBuildModule call s:maven("-Dmaven.test.skip -am -pl", <q-args>)
cabbrev build <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Build" : "build"<CR>
cabbrev run <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Run" : "run"<CR>
nmap <silent> <C-B> :Build<CR>
nmap <silent> <C-R> :Run<CR>
" }}}

" {{{ vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
" }}}

" {{{ vim-floaterm
autocmd User Startified setlocal buflisted
let g:floaterm_type = 'normal'
let g:floaterm_height = 0.35 * &lines
let g:floaterm_position = 'auto'
let g:floaterm_keymap_toggle = '<Ctrl>-d'
nnoremap <silent><Leader>tw :FloatermNew<CR>
" }}}

" {{{ quickui
if exists('*nvim_open_win') > 0
  call quickui#menu#reset()
  call quickui#menu#install('&File', [
        \ [ "&Open\t(:e)", 'call feedkeys(":e ")' ],
        \ [ "&Save\t(:w)", 'write' ],
        \ [ "--", ],
        \ [ "File &Explorer", 'Defx', 'Taggle file exporer' ],
        \ [ "Switch &Files", 'Files .' ],
        \ [ "Switch &Buffers", 'call quickui#tools#list_buffer("e")' ],
        \ [ "--", ],
        \ [ "E&xit", 'qa' ],
        \ ])

  call quickui#menu#install('&Edit', [
        \ [ "&Trailing Space", 'call utils#strip_trailing_whitespace()', '' ],
        \ [ "&Find\t", 'Ag', '' ],
        \ [ "F&ormat", 'Format' ],
        \ [ "&Hex Edit", 'Vinarise', 'Ultimate hex editing system with Vim' ],
        \ ])

  call quickui#menu#install('&Build', [
        \ [ "&Compile File\tCtrl-b", 'Build' ],
        \ [ "&E&xecute File\tCtrl-r", 'Run' ],
        \ [ '--','' ],
        \ [ "Clang &Format", 'ClangFormat' ],
        \ ])

  call quickui#menu#install('&Tools', [
        \ [ "View &Diff", 'Gdiffsplit' ], 
        \ [ "Show &Log", 'Gclog' ],
        \ [ "Git &Blame", 'Gblame' ],
        \ [ '--', '' ],
        \ [ "List &Function", 'call quickui#tools#list_function()', '' ],
        \ [ "Display &Messages", 'call quickui#tools#display_messages()', '' ],
        \ [ "&Tagbar", 'Vista!!', '' ],
        \ [ "&Choose Window/Tab", 'ChooseWin', '' ],
        \ [ "Display Ca&lendar", 'Calendar -first_day=monday', '' ],
        \ [ "Ter&minal", 'FloatermToggle', '' ],
        \ [ '--', '' ],
        \ [ "Plugin &Update", 'DeinUpdate', '' ],
        \ ])

  call quickui#menu#install('Help (&?)', [
        \ [ "&Cheatsheet", 'help index', '' ],
        \ [ 'T&ips', 'help tips', '' ],
        \ [ '--','' ],
        \ [ "&Tutorial", 'help tutor', '' ],
        \ [ '&Quick Reference', 'help quickref', '' ],
        \ [ '&Summary', 'help summary', '' ],
        \ [ '--','' ],
        \ [ "&Vim Script", 'help eval', '' ], 
        \ [ "&Function List", 'help function-list', '' ],
        \ ], 10000)
  let g:quickui_color_scheme = 'gruvbox'
  let g:quickui_border_style = 2
  " let g:quickui_show_tip = 1
  " tool bar open
  noremap <silent><Leader>to :call quickui#menu#open()<CR>
  nnoremap <silent><expr><Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":call quickui#tools#list_buffer('e')\<CR>"
endif
" }}}
