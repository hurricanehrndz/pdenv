local M = {}

function M.on_attach(_, buffer)
  local map = vim.keymap.set
  map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Lsp Info", buffer = buffer })
  map(
    "n",
    "gd",
    function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
    { desc = "Goto Definition", buffer = buffer }
  )
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References", buffer = buffer })
  map("n", "gD", "<cmd>Lspsaga goto_definition<cr>", { desc = "Goto Defintion", buffer = buffer })
  map(
    "n",
    "gI",
    function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
    { desc = "Goto Implementation", buffer = buffer }
  )
  map(
    "n",
    "gy",
    function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
    { desc = "Goto T[y]pe Definition", buffer = buffer }
  )
  map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover", buffer = buffer })
  map({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<cr>", { desc = "Code Action", buffer = buffer })
  map(
    { "n", "v" },
    "<leader>lA",
    require("actions-preview").code_actions,
    { desc = "Code Action Preview", buffer = buffer }
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
    function() vim.lsp.inlay_hint.enable(buffer, not vim.lsp.inlay_hint.is_enabled()) end,
    { desc = "Toggle hints" }
  )
end

return M
