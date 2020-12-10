"======================================================================
"
" mapping.vim - 
"
" Created by liubang on 2020/08/10
" Last Modified: 2020/08/10 00:40
"
"======================================================================

if dein#tap('nvim-tree.lua')
  function! s:tree_context_menu() abort
    let l:selection = confirm('Action?', "&New file/directory\n&Rename\n&Copy\n&Cut\n&Paste\n&Remove")
    silent exe 'redraw'
    if l:selection == 1 
      lua require'tree'.on_keypress('create')
    elseif l:selection == 2
      lua require'tree'.on_keypress('rename')
    elseif l:selection == 3
      lua require'tree'.on_keypress('copy')
    elseif l:selection == 4
      lua require'tree'.on_keypress('cut')
    elseif l:selection == 5
      lua require'tree'.on_keypress('paste')
    elseif l:selection == 6
      lua require'tree'.on_keypress('remove')
    endif
  endfunc

  nnoremap <silent><Leader>ft :lua require'tree'.toggle()<cr>

  function! s:lua_tree_mappings()
    nnoremap <silent><buffer>m :call <SID>tree_context_menu()<cr>
    nnoremap <silent><buffer>r :lua require'tree'.on_keypress('refresh')<cr>
    nnoremap <silent><buffer>s :lua require'tree'.on_keypress('split')<cr>
    nnoremap <silent><buffer>v :lua require'tree'.on_keypress('vsplit')<cr>
  endfunc

  augroup vfinit
    autocmd!
    autocmd FileType LuaTree call s:lua_tree_mappings() 
  augroup END
endif

if dein#tap('accelerated-jk')
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif

if dein#tap('vim-niceblock')
  xmap <silent>I <Plug>(niceblock-I)
  xmap <silent>gI <Plug>(niceblock-gI)
  xmap <silent>A <Plug>(niceblock-A)
endif

if dein#tap('caw.vim')
  map <silent><Leader>cc <Plug>(caw:hatpos:toggle)
  map <silent><Leader>cw <Plug>(caw:wrap:comment)
  map <silent><Leader>cu <Plug>(caw:wrap:uncomment)
  map <silent><Leader>cb <Plug>(caw:box:comment)
  map <silent><Leader>cp <Plug>(caw:jump:comment-prev)
  map <silent><Leader>cn <Plug>(caw:jump:comment-next)
endif

if dein#tap('vim-slash')
  noremap <plug>(slash-after) zz
endif

if dein#tap('vim-easy-align')
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endif

if dein#tap('vim-expand-region')
  vmap v <Plug>(expand_region_expand)
  vmap V <Plug>(expand_region_shrink)
endif

if dein#tap('vim-floaterm')
  nnoremap   <silent><Leader>tw :FloatermNew<CR>
  nnoremap   <silent><C-t>      :FloatermToggle<CR>
  tnoremap   <silent><C-n>      <C-\><C-n>:FloatermNew<CR>
  tnoremap   <silent><C-k>      <C-\><C-n>:FloatermPrev<CR>
  tnoremap   <silent><C-j>      <C-\><C-n>:FloatermNext<CR>
  tnoremap   <silent><C-t>      <C-\><C-n>:FloatermToggle<CR>
  tnoremap   <silent><C-d>      <C-\><C-n>:FloatermKill<CR>
endif

if dein#tap('vim-mundo')
  nnoremap <silent><Leader>ud :MundoToggle<CR>
endif

if dein#tap('asyncrun.vim')
  nnoremap <Leader>ar :AsyncRun<Space>
endif

if dein#tap('asynctasks.vim')
  nnoremap <silent><C-x> :AsyncTask file-build-and-run<CR>
  nnoremap <silent><C-b> :AsyncTask file-build<CR>
  nnoremap <silent><C-r> :AsyncTask file-run<CR> 
endif

if dein#tap('vista.vim')
  nnoremap <silent><leader>tl :Vista!!<CR>
  nnoremap <silent><leader>vf :Vista finder coc<CR>
endif

if dein#tap('coc.nvim')
  function! s:check_back_space() abort
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1]  =~# '\s'
  endfunc
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <silent><leader>gd <Plug>(coc-definition)
  nmap <silent><leader>gD <Plug>(coc-declaration)
  nmap <silent><leader>gy <Plug>(coc-type-definition)
  nmap <silent><leader>gi <Plug>(coc-implementation)
  nmap <silent><leader>gr <Plug>(coc-references)
  nmap <silent><leader>ei <Plug>(coc-diagnostic-info)
  nmap <silent><leader>rn <Plug>(coc-rename)
  nmap <silent><leader>rf <Plug>(coc-refactor)
  nmap <silent><leader>fm :call CocAction('format') <CR>
  nmap <silent>w <Plug>(coc-ci-w)
  nmap <silent>b <Plug>(coc-ci-b)
endif

if dein#tap('markdown-preview.nvim')
  nnoremap <silent><Leader>mp :MarkdownPreview<CR>
endif

if dein#tap('vim-clang-format')
  autocmd FileType c,cpp,objc nnoremap <silent><buffer><Leader>cf :<C-u>ClangFormat<CR>
  autocmd FileType c,cpp,objc vnoremap <silent><buffer><Leader>cf :ClangFormat<CR>
endif

if dein#tap('lightline-bufferline')
  nmap <silent> <expr> <Leader>1 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"
  nmap <silent> <expr> <Leader>2 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"
  nmap <silent> <expr> <Leader>3 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"
  nmap <silent> <expr> <Leader>4 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"
  nmap <silent> <expr> <Leader>5 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"
  nmap <silent> <expr> <Leader>6 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"
  nmap <silent> <expr> <Leader>7 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"
  nmap <silent> <expr> <Leader>8 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"
  nmap <silent> <expr> <Leader>9 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"
  nmap <silent> <expr> <Leader>0 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"
endif

if dein#tap('telescope.nvim')
  nnoremap <silent><Leader>ff <cmd>Telescope find_files<CR>
  nnoremap <silent><Leader>ag <cmd>Telescope live_grep<CR>
  nnoremap <silent><Leader>Ag <cmd>Telescope grep_string<CR>
  nnoremap <silent><Leader>bb <cmd>Telescope buffers<CR>
  nnoremap <silent><Leader>fc <cmd>Telescope commands<CR>
  nnoremap <silent><Leader>fb <cmd>Telescope builtin<CR>
endif

" if dein#tap('vim-clap')
"   nnoremap <silent> <Leader>tc :<C-u>Clap colors<CR>
"   nnoremap <silent> <Leader>bb :<C-u>Clap buffers<CR>
"   nnoremap <silent> <Leader>fa :<C-u>Clap grep2<CR>
"   nnoremap <silent> <Leader>fb :<C-u>Clap marks<CR>
"   " ctrl-p
"   nnoremap <silent> <C-p>      :<C-u>Clap filer<CR>
"   nnoremap <silent> <Leader>ff :<C-u>Clap files ++finder=rg --ignore --hidden --files<cr>
"   nnoremap <silent> <Leader>fg :<C-u>Clap gfiles<CR>
"   nnoremap <silent> <Leader>ag :<C-u>Clap grep<cr>
"   nnoremap <silent> <Leader>fw :<C-u>Clap grep ++query=<cword><cr>
"   nnoremap <silent> <Leader>fh :<C-u>Clap history<CR>
"   nnoremap <silent> <Leader>fW :<C-u>Clap windows<CR>
"   nnoremap <silent> <Leader>fl :<C-u>Clap loclist<CR>
"   nnoremap <silent> <Leader>fu :<C-u>Clap git_diff_files<CR>
"   nnoremap <silent> <Leader>fv :<C-u>Clap grep ++query=@visual<CR>
"   nnoremap <silent> <Leader>oc :<C-u>Clap dotfiles<CR>
"   nnoremap <silent> <LocalLeader>g :<C-u>Clap gosource<CR>
" endif
" 
if dein#tap('vim-quickui')
  " tab menu
  nnoremap <silent> <Leader>tm :call quickui#menu#open()<cr>
  nnoremap <silent>K :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>
endif
