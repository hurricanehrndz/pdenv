local M = {}

function M.on_attach(client, buffer)
  -- Enable completion triggered by <c-x><c-o>
  if client.server_capabilities.completionProvider then
    vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"
  end

  if client.server_capabilities.definitionProvider then
    vim.bo[buffer].tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  if client.name == "ruff_lsp" then
    client.server_capabilities.hoverProvider = false
  end
end

return M
