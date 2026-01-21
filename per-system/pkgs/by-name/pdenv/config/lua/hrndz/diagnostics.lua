local signs = require("hrndz.icons").diagnostics
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- default keymaps -- not needed -- nvim defaults
--[[
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
vim.keymap.set('n', '<C-w>d', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '<C-w><C-d>', '<cmd>lua vim.diagnostic.open_float()<cr>')
  ]]

-- diagnostic
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- inspired by lazyvim: https://sourcegraph.com/github.com/LazyVim/LazyVim/-/blob/lua/lazyvim/plugins/lsp/init.lua
vim.diagnostic.config({
  underline = true,
  update_in_insert = false, -- default to false
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true, -- default to false
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Info,
    },
  },
})
