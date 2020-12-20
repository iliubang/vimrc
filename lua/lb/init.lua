-- =====================================================================
--
-- init.lua -
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
-- =====================================================================
local g, fn = vim.g, vim.fn
local app = {}

_G.check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.dump = function(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

app.run = function(v)
  g.nvg_version = v
  g.nvg_root = fn.stdpath('config')
  g.cache_path = g.nvg_root .. '/.cache'
  g.module_path = g.nvg_root .. '/modules'
  g.snip_path = g.nvg_root .. '/snippets'

  -- plugins
  -- require('lb.plugins')
  -- LuaFormatter off
  require('lb.utils.pm').setup(
    require('lb.utils.fs').list_files(g.module_path, '*.toml')
  )
  -- LuaFormatter on
  require('lb.options')
  require('lb.mappings')
  require('lb.events')
  require('lb.commands')
end

return app
