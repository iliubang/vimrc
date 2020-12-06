local lspconfig = require('lspconfig')
local completion = require('completion')

vim.g.completion_confirm_key = ""
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_enable_snippet = 'snippets.nvim'

-- local telescope_mapper = require('telescope.mappings')
local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

function LspRename()
  local current_word = vim.fn.expand("<cword>")
  local plenary_window = require('plenary.window.float').percentage_range_window(0.5, 0.2)
  vim.api.nvim_buf_set_option(plenary_window.bufnr, 'buftype', 'prompt')
  vim.fn.prompt_setprompt(plenary_window.bufnr, string.format('Rename "%s" to > ', current_word))
  vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
    vim.api.nvim_win_close(plenary_window.win_id, true)

    if text ~= '' then
      vim.schedule(function()
        vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })
        vim.lsp.buf.rename(text)
      end)
    else
      print("Nothing to rename!")
    end
  end)

  vim.cmd [[startinsert]]
end

local custom_attach = function(client, bufnr)
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
  completion.on_attach(client, bufnr)

  mapper('n', '<leader>gd', 'vim.lsp.buf.definition()')
  mapper('n', '<leader>gD', 'vim.lsp.buf.declaration()')
  mapper('n', '<leader>gi', 'vim.lsp.buf.implementation()')
  -- mapper('n', '<leader>gr', 'vim.lsp.buf.references()')
  mapper('n', '<leader>rn', 'LspRename()')
  mapper('i', '<c-s>', 'vim.lsp.signature_help()')

  -- telescope_mapper('<leader>gr', 'lsp_references', nil, true)
  -- telescope_mapper('<leader>ca', 'lsp_code_actions', nil, true)

  if vim.tbl_contains({"go", "rust"}, filetype) then
    vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
  end

  -- local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  -- if filetype ~= 'lua' then
  --   mapper('n', 'k', 'vim.lsp.buf.hover()')
  -- end
end

-- for python
lspconfig.pyls.setup({
  enable = true,
  plugins = {
    pyls_mypy = {
      enabled = true,
      live_mode = false
    }
  },
  on_attach = custom_attach
})

-- for vimscript
lspconfig.vimls.setup({
  on_attach = custom_attach
})

-- for golang
lspconfig.gopls.setup({
  cmd = {"gopls", "--remote=auto"},
  init_options = {
    usePlaceholders=true,
    completeUnimported=true,
  },
  on_attach = custom_attach
})

-- for lua
require('nlua.lsp.nvim').setup(lspconfig, {
  on_attach = custom_attach,
  globals = {
    "Color", "c", "Group", "g", "s",
    "RELOAD",
  },
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {"vim"}
      },
      runtime = {version = "LuaJIT"},
      workspace = {
        library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}),
      },
    },
  }
})

-- for javascript
lspconfig.tsserver.setup({
  on_attach = custom_attach
})

-- for c/c++
lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  on_attach = custom_attach,
  init_options = {
    clangdFileStatus = true
  }
})

-- for Dockerfile
lspconfig.dockerls.setup({
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "Dockerfile", "dockerfile" },
  on_attach = custom_attach,
})


-- for sh
lspconfig.bashls.setup({
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh" },
  on_attach = custom_attach,
})
