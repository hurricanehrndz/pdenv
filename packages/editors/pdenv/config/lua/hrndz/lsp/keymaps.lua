local M = {}

function M.on_attach(_, buffer)
  local map = vim.keymap.set
  map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Lsp Info", buffer = buffer })
  map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover", buffer = buffer })
  map({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<cr>", { desc = "Code Action", buffer = buffer })
  -- map(
  --   { "n", "v" },
  --   "<leader>lA",
  --   require("actions-preview").code_actions,
  --   { desc = "Code Action Preview", buffer = buffer }
  -- )
  map(
    "n",
    "<leader>ca",
    function() require("tiny-code-action").code_action() end,
    { desc = "Code Action Preview", buffer = buffer, noremap = true, silent = true }
  )
  map(
    { "n" },
    "<C-k>",
    function() require("lsp_signature").toggle_float_win() end,
    { silent = true, noremap = true, desc = "toggle signature" }
  )
  map("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })
  map(
    "n",
    "<leader>lh",
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled() ) end,
    { desc = "Toggle hints" }
  )
end

return M
