-- =====================================================================
--
-- commands.lua -
--
-- Created by liubang on 2020/12/12 18:32
-- Last Modified: 2020/12/12 18:32
--
-- =====================================================================
vim.schedule(function()
  vim.cmd [[command! -nargs=0 -bar PlugUpdate call dein#update()]]
  vim.cmd [[command! -nargs=0 -bar PlugClean  call map(dein#check_clean(), "delete(v:val, 'rf')")]]
  vim.cmd [[command! -nargs=0 -bar ReRuntimePath  call dein#recache_runtimepath()]]
  vim.cmd [[command! -nargs=0 -bar Filepath echo expand('%:p')]]
  vim.cmd [[command! -nargs=0 -bar CopyRight :lua require('lb.utils.comment').copy_right('liubang')]]
  vim.cmd [[command! -nargs=0 -bar CopyRightUpdate :lua require('lb.utils.comment').copy_right_update()]]
  vim.cmd [[command! -nargs=0 -bar BazelRules :lua require('telescope').extensions.bazel.bazel_rules(require('telescope.themes').get_dropdown({}))<CR>]]
  vim.cmd [[command! -nargs=0 -bar BazelTests :lua require('telescope').extensions.bazel.bazel_rules(require('telescope.themes').get_dropdown({}))<CR>]]
  vim.cmd [[command! -nargs=0 -bar BazelBinaries :lua require('telescope').extensions.bazel.bazel_rules(require('telescope.themes').get_dropdown({}))<CR>]]
end)
