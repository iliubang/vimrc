" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

let g:lbvim_version = '0.1'
let g:lbvim_home = $HOME.'/.vim.rc'

let g:MAC = has('macunix')
let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = has('win32') || has('win64')

if g:WINDOWS
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
set runtimepath+=$HOME/.vim.rc

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if &compatible
  set nocompatible
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir) 
  call dein#add(s:dein_repo_dir)
  call dein#add('Shougo/deoplete.nvim', {'on_i': 1})
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('mhinz/vim-startify')
  call dein#add('liuchengxu/eleline.vim')
  call dein#add('easymotion/vim-easymotion', {'on_i': 0})
  call dein#add('jiangmiao/auto-pairs', {'on_i': 1})
  call dein#add('tpope/vim-surround', {'on_i': 1})
  call dein#add('Shougo/unite.vim', {'on_i': 1})
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('zchee/deoplete-jedi', {'on_ft': ['py']})
  call dein#add('tweekmonster/deoplete-clang2', {'on_ft': ['c', 'cpp']})
  call dein#add('ervandew/supertab')
  call dein#add('terryma/vim-multiple-cursors', {'on_i': 1})
  call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
  call dein#add('scrooloose/nerdcommenter', {'on_cmd': ['NERDComComment', 'NERDComNestedComment', 'NERDComToggleComment']})
  call dein#add('SirVer/ultisnips', {'on_i': 1})
  call dein#add('iliubang/vim-snippets', {'on_i': 1})
  call dein#add('iliubang/yadracula')
  call dein#add('dhruvasagar/vim-table-mode', {'on_cmd' : ['TableModeToggle', 'TableModeEnable']})
  call dein#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
  call dein#add('junegunn/fzf.vim', {'on_cmd': 'FZF'})
  call dein#add('dominikduda/vim_current_word', {'on_i': 0})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" smart default {{{
syntax on
set shortmess=atOI
set ignorecase
set smartcase 
set scrolljump=5
set scrolloff=3
set hidden
set history=100
set nowrap
set hlsearch
set nowritebackup
set noundofile
set nobackup
set noswapfile
set number
set shiftwidth=4
set tabstop=4
set softtabstop=4
set mousehide
set ruler
set showcmd
set showmode
set showmatch
set matchtime=5
set report=0
set linespace=0
set pumheight=20
set winminheight=0
set wildmode=list:longest,full
set backspace=2         " 在insert模式下用退格键删除
set whichwrap+=<,>,h,l  " Allow backspace and cursor keys to cross line boundaries
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so     " Unix
set wildignore+=*\\tmp\\*,*.exe            " Windows
set cursorline
set fileformats=unix,dos,mac
set fillchars=vert:\|,stl:\ ,stlnc:\       " 在被分割窗口之间显示空白
set autoread                               " 文件在Vim之外修改过，自动重新读入
set synmaxcol=200
set norelativenumber
"set colorcolumn=120
set nocursorcolumn
" Enable folding
" 快捷键：z+a, 打开或关闭当前折叠;  z+m, 关闭所有折叠;  z+r, 打开所有折叠
" set nofoldenable  "启动vim时候关闭折叠
set foldmethod=marker
set foldcolumn=0 
" set foldlevel=99
" 禁用报警声和图标
set noerrorbells
set novisualbell
" }}}

" about theme {{{
set t_Co=256
set laststatus=2
set background=dark
colorscheme yadracula
let g:yadracula_contrast='hard'
let g:yadracula_contrast_dark='hard'
" }}}

try
  execute 'source '.g:lbvim_home.'/startify.vim'
catch
endtry

" vim-startify {{{
let g:startify_custom_header = g:vim#startify#header
let g:startify_list_order = g:vim#startify#order
let g:startify_change_to_vcs_root = 1
" }}}

nnoremap <Space> <NOP>
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"

" Open shell in vim {{{
if has('nvim')
  map <Leader>' :terminal<CR>
else
  map <Leader>' :shell<CR>
endif
" }}}

" Quit normal mode {{{
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>Q  :qa!<CR>
" }}}

" Bash like {{{
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
" }}}

" Quit visual mode {{{
vnoremap v <Esc>
" }}}

" buffer {{{
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bk :bw<CR>
" }}}

" window {{{
nnoremap <Leader>ww <C-W>w
nnoremap <Leader>wr <C-W>r
nnoremap <Leader>wd <C-W>c
nnoremap <Leader>wq <C-W>q
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wl <C-W>l
nnoremap <Leader>wH <C-W>5<
nnoremap <Leader>wL <C-W>5>
nnoremap <Leader>wJ :resize +5<CR>
nnoremap <Leader>wK :resize -5<CR>
nnoremap <Leader>w= <C-W>=
nnoremap <Leader>ws <C-W>s
nnoremap <Leader>w- <C-W>s
nnoremap <Leader>wv <C-W>v
nnoremap <Leader>w\| <C-W>v
nnoremap <Leader>w2 <C-W>v
" }}}

" easymotion {{{
map <Leader><Leader> <Plug>(easymotion-prefix)
" Consistent with spacemacs
" <Leader>f{char} to move to {char}
map  <Leader>jj <Plug>(easymotion-bd-f)
nmap <Leader>jj <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap <Leader>jJ <Plug>(easymotion-overwin-f2)
" Jump to line
map <Leader>jl <Plug>(easymotion-bd-jk)
nmap <Leader>jl <Plug>(easymotion-overwin-line)
" Jump to word
map  <Leader>jw <Plug>(easymotion-bd-w)
nmap <Leader>jw <Plug>(easymotion-overwin-w)
" }}}

" nerdtree {{{
let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeIgnore=[
			\ '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$',
			\ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$',
			\ ]
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <F4> :NERDTreeToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>
nnoremap <Leader>ft :NERDTreeToggle<CR>
nnoremap <Leader>fd :NERDTreeFind<CR>
" }}}

" {{{ nerdcommenter
" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1
" }}}

" fzf {{{
let $LANG = 'en_US'
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

nmap <Leader>? <plug>(fzf-maps-n)
xmap <Leader>? <plug>(fzf-maps-x)
omap <Leader>? <plug>(fzf-maps-o)
nnoremap <Leader>ag :Ag<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>b? :Buffers<CR>
nnoremap <Leader>w? :Windows<CR>
nnoremap <Leader>f? :FZF ~<CR>
nnoremap <Leader>ff :FZF<CR>
" }}}

" deoplete {{{
" Use deoplete.
let g:deoplete#enable_at_startup = 1
" }}}

" jedi-vim {{{ 
let g:jedi#popup_select_first=1
set completeopt=longest,menuone
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
" let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\)\w*'
let g:jedi#show_call_signatures = "0"   " 补全时不弹出函数的参数列表框
" }}}

" supertab {{{
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 1
" }}}

" clang {{{
if g:MAC 
  let g:deoplete#sources#clang#flags = ['-I/usr/include', '-I/usr/include/c++/4.2.1', '-I/usr/local/opt/llvm/lib/clang/5.0.1/include']
endif
if g:LINUX
  let g:deoplete#sources#clang#flags = ['-I/usr/include', '-I/usr/include/c++/7.2.0', '-I/usr/include/clang/4.0.1/include']
endif
let g:deoplete#sources#clang#executable = "/usr/bin/clang"
let g:deoplete#sources#clang#autofill_neomake = 1
let g:neomake_c_enabled_makers = ['clang']
let g:neomake_cpp_enabled_makers = ['clang']
let g:deoplete#sources#clang#std={'c': 'c11', 'cpp': 'c++1z', 'objc': 'c11', 'objcpp': 'c++1z'}
" }}}

