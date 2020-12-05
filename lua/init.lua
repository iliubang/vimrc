local ok, msg = pcall(function() require ('lsp.lsp_config') end)
if not ok then
  print(msg)
end
