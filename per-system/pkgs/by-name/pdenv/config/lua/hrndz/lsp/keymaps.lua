local M = {}

function M.has(buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then return true end
    end
    return false
  end
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client:supports_method(method) then return true end
  end
  return false
end

function M.on_attach(_, buffer)
  local bufmap = function(mode, rhs, lhs, opts)
    local bufopts = vim.tbl_deep_extend("force", { buffer = buffer }, opts)
    vim.keymap.set(mode, rhs, lhs, bufopts)
  end
  -- default keymaps
  --[[
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'grr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
    bufmap({'i', 's'}, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
  ]]

  -- tiny code action
  bufmap({ "n", "x" }, "<leader>ca", function() require("tiny-code-action").code_action({}) end, { desc = "Code Action" })
  bufmap("n", "<leader>cl", function() Snacks.picker.lsp_config() end, { desc = "Lsp Info" })

  if M.has(buffer, "definition") then bufmap("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" }) end
  if M.has(buffer, "codeLens") then
    bufmap({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
    bufmap("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
  end
  if M.has(buffer, "signatureHelp") then
    bufmap({ "i", "s" }, "<c-k>", function() return vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
  end

  bufmap("n", "grt", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
  bufmap("n", "grd", vim.lsp.buf.declaration, { desc = "Goto Declaration" })

  if M.has(buffer, "documentHighlight") then
    bufmap("n", "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
    bufmap("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
    bufmap("n", "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, { desc = "Next Reference" })
    bufmap("n", "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, { desc = "Prev Reference" })
  end
end

return M
