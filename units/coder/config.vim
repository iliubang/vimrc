"======================================================================
"
" config.vim - 
"
" Created by liubang on 2019/11/17
" Last Modified: 2019/11/17 00:22:39
"
"======================================================================

" lsp
let g:coc_global_extensions = ['coc-word',
                              \'coc-json',
                              \'coc-highlight',
                              \'coc-snippets',
                              \'coc-emmet',
                              \'coc-css',
                              \'coc-tailwindcss',
                              \'coc-html',
                              \'coc-vetur',
                              \'coc-angular',
                              \'coc-yaml',
                              \'coc-java',
                              \'coc-rls',
                              \'coc-tsserver',
                              \'coc-vimlsp',
                              \'coc-emoji',
                              \'coc-pairs',
                              \'coc-git',
                              \'coc-yank',
                              \'coc-post',
                              \'coc-stylelint',
                              \'coc-diagnostic',
                              \'coc-tabnine',
                              \'coc-prettier',
                              \'coc-sql',
                              \'coc-xml',
                              \'coc-lists',
                              \ ]

" c/c++
let c_no_curly_error=1
let g:clang_format#detect_style_file = 1
let g:clang_format#enable_fallback_style = 1
autocmd FileType c,cpp,proto nnoremap <silent><buffer><leader>cf :<c-u>ClangFormat<cr>
autocmd FileType c,cpp,proto vnoremap <silent><buffer><leader>cf :ClangFormat<cr>
if g:nvg.os.mac 
  call coc#config('languageserver', {
    \ 'ccls': {
    \   'command': 'ccls',
    \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
    \   'rootPatterns': ['.ccls', 'compile_commands.json', '.git'],
    \   'initializationOptions': {
    \     'cache': {'directory': '/tmp/ccls'},
    \     'clang': {
    \       'resourceDir': g:nvg.ccls.clang_resourcedir,
    \       'extraArgs': [
    \         '-isystem',
    \         g:nvg.ccls.clang_isystem,
    \         '-I',
    \         g:nvg.ccls.clang_include,
    \       ]
    \     }
    \   }
    \ }
    \ })
elseif g:nvg.os.linux 
  call coc#config('languageserver', {
    \ 'ccls': {
    \   'command': 'ccls',
    \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
    \   'rootPatterns': ['.ccls', 'compile_commands.json', '.git'],
    \   'initializationOptions': {
    \     'cache': {'directory': '/tmp/ccls'},
    \     'clang': {
    \       'extraArgs': [
    \         '--gcc-toolchain=/usr'
    \       ]
    \     }
    \   }
    \ }
    \ })
endif

" vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
"disable use K to run godoc
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0

" coc.nvim
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
function! s:check_back_space() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr><cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gD <Plug>(coc-declaration)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)
nmap <silent><leader>ei <Plug>(coc-diagnostic-info)
nmap <silent><leader>rn <Plug>(coc-rename)
vmap <silent><leader>fm <Plug>(coc-format-selected)
nmap <silent><leader>fm <Plug>(coc-format-selected)
nnoremap <silent> <Space><Space> :CocList<CR>
nnoremap <silent> <space>y       :<C-u>CocList -A --normal yank<cr>
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)

augroup coc_au
  autocmd!
  autocmd FileType go let b:coc_pairs_disabled = ['<']
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocQuickfixChange :CocList --normal quickfix
  autocmd CursorHold * silent call CocActionAsync('highlight')

  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  " virtual text highlight
  autocmd ColorScheme * highlight! CocCodeLens guifg=#606060 ctermfg=60
  " error/warning/info/hit sign
  autocmd ColorScheme * highlight! CocErrorSign ctermfg=Red guifg=#ea6962
  autocmd ColorScheme * highlight! CocWarningSign ctermfg=Yellow guifg=#e3a84e
  autocmd ColorScheme * highlight! CocInfoSign ctermfg=Blue guifg=#7dae9b
  autocmd ColorScheme * highlight! CocHintSign ctermfg=Blue guifg=#7dae9b
  " diff sign highlight groups
  autocmd ColorScheme * highlight GitAddHi    guifg=#b8bb26 ctermfg=40
  autocmd ColorScheme * highlight GitModifyHi guifg=#83a598 ctermfg=33
  autocmd ColorScheme * highlight GitDeleteHi guifg=#f3423a ctermfg=196
  autocmd ColorScheme * highlight CocCursorRange guibg=#b16286 guifg=#ebdbb2
  " highlight text color
  autocmd ColorScheme * highlight! CocHighlightText  guibg=#054c20 ctermbg=023
  " do not underline error/info/hit lines
  autocmd ColorScheme * highlight! link CocErrorHighlight NoCocUnderline
  autocmd ColorScheme * highlight! link CocWarningHighlight NoCocUnderline
  autocmd ColorScheme * highlight! link CocInfoHighlight NoCocUnderline
  autocmd ColorScheme * highlight! link CocHintHighlight NoCocUnderline
augroup END
