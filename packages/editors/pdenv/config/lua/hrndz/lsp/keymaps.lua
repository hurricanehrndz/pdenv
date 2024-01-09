local M = {}

function M.on_attach(_, buffer)
  local map = vim.keymap.set
  map("n", "<leader>cl", "<cmd>LspInfo<cr>",  { desc = "Lsp Info", buffer = buffer })
  map("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "Goto Definition", buffer = buffer })
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References", buffer = buffer })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", buffer = buffer })
  map("n", "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "Goto Implementation", buffer = buffer })
  map("n", "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "Goto T[y]pe Definition", buffer = buffer })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = buffer })
  map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = buffer })
  map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = buffer })
  map({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = buffer })
  map(
    "n",
    "<leader>cA",
    function()
      vim.lsp.buf.code_action({
        context = {
          only = {
            "source",
          },
          diagnostics = {},
        },
      })
    end,
    { desc = "Source Action", buffer = buffer }
  )
end

return M
