"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:36:05
"
"======================================================================

let g:python3_host_skip_check = 1
let g:python3_host_prog = 'python3'

let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#sources#syntax#min_keyword_length = 3
let g:neosnippet#enable_completed_snippet = 1
set completeopt-=preview
let g:deoplete#auto_complete_delay = 5  " Default is 50
let g:deoplete#auto_refresh_delay = 30  " Default is 500

" Define the input_patterns mapping so that it can be configured
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

call deoplete#custom#option('refresh_always', v:false)
call deoplete#custom#option('camel_case', v:false)
call deoplete#custom#option('ignore_case', v:true)
call deoplete#custom#option('smart_case', v:true)
call deoplete#custom#option('on_insert_enter', v:true)
call deoplete#custom#option('on_text_changed_i', v:true)
call deoplete#custom#option('min_pattern_length', 1)
call deoplete#custom#option('num_processes', 10)
call deoplete#custom#option('max_list', 10000)
call deoplete#custom#option('skip_chars', ['(', ')', '<', '>'])

let g:deoplete#sources = get(g:, 'deoplete#sources', {})
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})

call deoplete#custom#source('omni',          'mark', '<omni>')
call deoplete#custom#source('flow',          'mark', '<flow>')
call deoplete#custom#source('phpcd',         'mark', '<php>')
call deoplete#custom#source('tern',          'mark', '<tern>')
call deoplete#custom#source('go',            'mark', '<go>')
call deoplete#custom#source('jedi',          'mark', '<jedi>')
call deoplete#custom#source('vim',           'mark', '<vim>')
call deoplete#custom#source('neosnippet',    'mark', '<snip>')
call deoplete#custom#source('tag',           'mark', '<tag>')
call deoplete#custom#source('around',        'mark', '<around>')
call deoplete#custom#source('buffer',        'mark', '<buf>')
call deoplete#custom#source('tmux-complete', 'mark', '<tmux>')
call deoplete#custom#source('syntax',        'mark', '<syntax>')
call deoplete#custom#source('member',        'mark', '<member>')
call deoplete#custom#source('UltiSnips',     'mark', '<UltiSnips>')

call deoplete#custom#source('UltiSnips',     'rank', 670)
call deoplete#custom#source('phpcd',         'rank', 660)
call deoplete#custom#source('go',            'rank', 650)
call deoplete#custom#source('vim',           'rank', 640)
call deoplete#custom#source('flow',          'rank', 630)
call deoplete#custom#source('TernJS',        'rank', 620)
call deoplete#custom#source('jedi',          'rank', 610)
call deoplete#custom#source('omni',          'rank', 600)
call deoplete#custom#source('neosnippet',    'rank', 510)
call deoplete#custom#source('member',        'rank', 500)
call deoplete#custom#source('file_include',  'rank', 420)
call deoplete#custom#source('file',          'rank', 410)
call deoplete#custom#source('tag',           'rank', 400)
call deoplete#custom#source('around',        'rank', 330)
call deoplete#custom#source('buffer',        'rank', 320)
call deoplete#custom#source('dictionary',    'rank', 310)
call deoplete#custom#source('tmux-complete', 'rank', 300)
call deoplete#custom#source('syntax',        'rank', 200)
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

call deoplete#custom#source('_', 'converters', [
	\ 'converter_remove_paren',
	\ 'converter_remove_overlap',
	\ 'converter_truncate_abbr',
	\ 'converter_truncate_menu',
	\ 'converter_auto_delimiter',
	\ ])

if !g:IS_NVIM
  if g:HAS_PYTHON
    set pyxversion=2
  elseif g:HAS_PYTHON3
    set pyxversion=3
  endif
endif

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 1

let g:UltiSnipsSnippetDirectories=['UltiSnips']
if g:HAS_PYTHON
  let g:UltiSnipsUsePythonVersion = 2
elseif g:HAS_PYTHON3
  let g:UltiSnipsUsePythonVersion = 3
endif

"let g:UltiSnipsExpandTrigger = '<C-k>'
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
