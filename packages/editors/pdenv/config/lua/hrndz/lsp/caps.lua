local M = {}

function M.on_attach(client, buffer)
  -- Enable completion triggered by <c-x><c-o>
  if client.server_capabilities.completionProvider then
    vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"
  end

  if client.server_capabilities.definitionProvider then
    vim.bo[buffer].tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
  end

  if client.name == "sourcekit" then
    client.server_capabilities.inlayHintProvider = true
  end

  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    -- Enable inlay hints by default
    vim.lsp.inlay_hint.enable()
  end
end

return M
