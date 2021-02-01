-- =====================================================================
--
-- mappings.lua - 
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2020/12/12 12:56
--
-- =====================================================================
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  -- rewrite options
  if opts then
    for k, v in pairs(opts) do
      options[k] = v
    end
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function detect(plug)
  if vim.fn.exists('*dein#tap') ~= 0 then
    return vim.fn['dein#tap'](plug) > 0
  end
  return true
end

-- clear default
map('n', ' ', '')
map('x', ' ', '')
map('n', ',', '')
map('x', ',', '')
map('n', ';', '')
map('x', ';', '')
map('n', 'm', '')
map('x', 'm', '')

-- better
map('v', '<Tab>', '>gv|')
map('v', '<S-Tab>', '<gv')
map('n', '<Tab>', '>>_')
map('n', '<S-Tab>', '<<_')

-- buffer
map('n', '<Leader>bp', '<cmd>bprevious<CR>')
map('n', '<Leader>bn', '<cmd>bnext<CR>')
map('n', '<Leader>bf', '<cmd>bfirst<CR>')
map('n', '<Leader>bl', '<cmd>blast<CR>')
map('n', '<Leader>bd', '<cmd>bdelete<CR>')

-- window
map('n', '<Leader>ww', '<C-W>w')
map('n', '<Leader>wr', '<C-W>r')
map('n', '<Leader>wd', '<C-W>d')
map('n', '<Leader>wq', '<C-W>q')
map('n', '<Leader>wj', '<C-W>j')
map('n', '<Leader>wJ', '<C-W>J')
map('n', '<Leader>wk', '<C-W>k')
map('n', '<Leader>wK', '<C-W>K')
map('n', '<Leader>wh', '<C-W>h')
map('n', '<Leader>wH', '<C-W>H')
map('n', '<Leader>wl', '<C-W>l')
map('n', '<Leader>wL', '<C-W>L')
map('n', '<Leader>w=', '<C-W>=')
map('n', '<Leader>ws', '<C-W>s')
map('n', '<Leader>w-', '<C-W>-')
map('n', '<Leader>wv', '<C-W>v')

map('x', '<', '<gv')
map('x', '>', '>gv')

-- bash like
map('i', '<C-a>', '<Home>')
map('i', '<C-e>', '<End>')
map('i', '<C-d>', '<Delete>')

-- command mod
map('c', '<C-a>', '<Home>')
map('c', '<C-e>', '<End>')
map('c', '<C-b>', '<S-Left>')
map('c', '<C-f>', '<S-right>')
map('c', '<C-h>', '<Left>')
map('c', '<C-l>', '<Right>')
map('c', '<C-n>', 'pumvisible() ? \'<Right>\' : \'<Down>\'', {expr = true})
map('c', '<C-p>', 'pumvisible() ? \'<Left>\' : \'<Up>\'', {expr = true})

-- insert mod

-- terminal
map('t', '<Esc>', '<C-\\><C-n>')
map('t', '<Leader>wh', '<C-\\><C-N><C-w>h')
map('t', '<Leader>wj', '<C-\\><C-N><C-w>j')
map('t', '<Leader>wl', '<C-\\><C-N><C-w>l')
map('t', '<Leader>wk', '<C-\\><C-N><C-w>k')

-- plugins key mappings
-- LuaFormatter off
if detect('nvim-tree.lua') then
  map('n', "<Leader>ft", "<cmd>lua require('nvim-tree').toggle()<CR>")
end

if detect('nerdcommenter') then
  map('n', "<Leader>cc", ':call NERDComment(\'n\', \'toggle\')<CR>')
  map('x', "<Leader>cc", ':call NERDComment(\'x\', \'toggle\')<CR>')
  map('n', "<Leader>cn", ':call NERDComment(\'n\', \'sexy\')<CR>')
  map('x', "<Leader>cn", ':call NERDComment(\'x\', \'sexy\')<CR>')
end

if detect('vim-easy-align') then
  map('x', 'ga', "<Plug>(EasyAlign)", {noremap = false})
  map('n', 'ga', "<Plug>(EasyAlign)", {noremap = false})
end

if detect('vim-expand-region') then
  map('v', 'v', "<Plug>(expand_region_expand)", {noremap = false})
  map('v', 'V', "<Plug>(expand_region_shrink)", {noremap = false})
end

if detect('vim-floaterm') then
  map('n', "<Leader>tw", "<cmd>FloatermNew<CR>")
  map('n', "<C-t>", "<cmd>FloatermToggle<CR>")
  map('t', "<C-n>", "<C-\\><C-n>:FloatermNew<CR>")
  map('t', "<C-k>", "<C-\\><C-n>:FloatermPrev<CR>")
  map('t', "<C-j>", "<C-\\><C-n>:FloatermNext<CR>")
  map('t', "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>")
  map('t', "<C-d>", "<C-\\><C-n>:FloatermKill<CR>")
end

if detect('vim-mundo') then
  map('n', "<Leader>ud", "<cmd>MundoToggle<CR>") 
end

if detect('asyncrun.vim') then
  map('n', "<Leader>ar", "<cmd>AsyncRun ")
end

if detect('asynctasks.vim') then
  map('n', "<C-x>", "<cmd>AsyncTask file-build-and-run<CR>")
  map('n', "<C-b>", "<cmd>AsyncTask file-build<CR>")
  map('n', "<C-r>", "<cmd>AsyncTask file-run<CR>")
end

if detect('vista.vim') then
  map('n', "<Leader>tl", "<cmd>Vista!!<CR>")
end

-- lsp
map('n', '<Leader>gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<Leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<Leader>hh', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<Leader>ee', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
-- formatting
map('n', '<Leader>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('v', '<Leader>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>')

if detect('nvim-compe') then
  map('i', '<TAB>', [[pumvisible() ? '<C-n>' : vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : v:lua.check_back_space() ? '<TAB>' : compe#complete()]], {expr = true, noremap = false})
  map('i', "<S-TAB>", [[pumvisible() ? '<C-p>' : '<C-h>']], {expr = true})
  map('i', '<CR>', [[compe#confirm({ 'keys': '<Plug>delimitMateCR', 'mode': '' })]], {expr = true})
end

if detect('markdown-preview.nvim') then
  map('n', "<Leader>mp", "<cmd>MarkdownPreview<CR>")
end

if detect('nvim-bufferline.lua') then
  for i = 1, 9 do
    map('n', "<leader>" .. i, '(v:lua.is_special_buffer() ? "<c-w><c-w>" : "") . ":lua require(\'bufferline\').go_to_buffer(' .. i .. ')<CR>"', {expr = true})
  end
end

if detect('telescope.nvim') then
  map('n', "<Leader>ff", ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false}))<CR>")
  map('n', "<Leader>ag", ":lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({}))<CR>")
  map('n', "<Leader>Ag", ":lua require('telescope.builtin').grep_string(require('telescope.themes').get_dropdown({}))<CR>")
  map('n', "<Leader>bb", ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({previewer = false}))<CR>")
  map('n', "<Leader>fc", ":lua require('telescope.builtin').commands(require('telescope.themes').get_dropdown({previewer = false}))<CR>")
  map('n', "<Leader>fb", ":lua require('telescope.builtin').builtin(require('telescope.themes').get_dropdown({previewer = false}))<CR>")
  map('n', "<Leader>ts", ":lua require('telescope').extensions.tasks.tasks(require('telescope.themes').get_dropdown({}))<CR>")
  map('n', "<Leader>br", ":lua require('telescope').extensions.bazel.bazel_rules(require('telescope.themes').get_dropdown({}))<CR>")
  map('n', "<Leader>bt", ":lua require('telescope').extensions.bazel.bazel_tests(require('telescope.themes').get_dropdown({}))<CR>")
  map('n', "<Leader>be", ":lua require('telescope').extensions.bazel.bazel_binaries(require('telescope.themes').get_dropdown({}))<CR>")
end
-- LuaFormatter on
