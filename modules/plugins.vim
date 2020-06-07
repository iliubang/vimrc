if empty(glob(g:nvg_root . '/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif

call plug#begin(g:nvg_root . '/.cache/plugged')
" theme and ui
Plug 'ryanoasis/vim-devicons'
Plug 'sainnhe/gruvbox-material'
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" search 
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} 
Plug 'junegunn/fzf.vim'

" tools
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive', {'on': [ 
      \ 'G', 
      \ 'Git', 
      \ 'Gfetch', 
      \ 'Gpush', 
      \ 'Glog', 
      \ 'Gclog', 
      \ 'Gdiffsplit', 
      \ 'Gblame' 
      \ ]}
Plug 'kana/vim-textobj-user'
Plug 'junegunn/vim-easy-align', {'on': [ 
      \ '<Plug>(EasyAlign)',
      \ ]}
Plug 'terryma/vim-expand-region'
Plug 'voldikss/vim-floaterm', {'on': [ 
      \ 'FloatermNew', 
      \ 'FloatermToggle', 
      \ 'FloatermPrev', 
      \ 'FloatermNext', 
      \ 'FloatermSend']}
Plug 'Shougo/vinarise.vim', {'on': 'Vinarise'}
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'justinmk/vim-sneak', {'on': [
      \ '<Plug>Sneak_f',
      \ '<Plug>Sneak_F',
      \ '<Plug>Sneak_t',
      \ '<Plug>Sneak_T',
      \ ]}
" Plug 'norcalli/nvim-colorizer.lua'

" document
Plug 'iamcco/markdown-preview.nvim', {'on': 'MarkdownPreview'}

" Plug 'machakann/vim-sandwich'
" Plug 'skywind3000/vim-quickui'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim', {'on': ['AsyncTask', 'TaskList', 'TaskListFzf']}

" file manager
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
Plug 'Shougo/defx.nvim', {'do': ':UpdateRemotePlugins'}

" programming
Plug 'neoclide/coc.nvim',  {'do': 'yarn install --frozen-lockfile'}
Plug 'honza/vim-snippets'
Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
Plug 'preservim/nerdcommenter', {'on': [ 
      \ '<Plug>NERDCommenterToggle', 
      \ '<Plug>NERDCommenterSexy', 
      \ '<Plug>NERDCommenterUncomment' 
      \ ]}
Plug 'rhysd/vim-clang-format', {'on': ['ClangFormat'], 'for': ['c', 'cpp']}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}

" filetype
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'neoclide/jsonc.vim', {'for': ['json', 'jsonc']}
call plug#end()
