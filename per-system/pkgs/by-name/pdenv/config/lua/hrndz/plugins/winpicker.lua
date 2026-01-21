local map = vim.keymap.set
require("nvim-window").setup({})
map("n", ",w", function() return require("nvim-window").pick() end, { noremap = true, desc = "Pick window" })
