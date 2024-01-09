local map = vim.keymap.set
local wk = require("which-key")
wk.register({
  ["<leader>gd"] = { name = "+DiffView" },
})
map("n", "<leader>gdt", "<cmd>DiffviewToggleFiles<CR>", { desc = "Toggle file tree" })
map("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>",  { desc = "Open" })
map("n", "<leader>gdx", "<cmd>DiffviewClose<CR>", { desc = "Close" })
map("n", "<leader>gdr", "<cmd>DiffviewRefresh<CR>",  { desc = "Refresh" })
