-- window navigation and resizing (native, no multiplexer integration)
local map = vim.keymap.set

-- navigate splits (normal + terminal mode)
map({ "n", "t" }, "<A-h>", "<Cmd>wincmd h<CR>", { desc = "Go to left window" })
map({ "n", "t" }, "<A-j>", "<Cmd>wincmd j<CR>", { desc = "Go to lower window" })
map({ "n", "t" }, "<A-k>", "<Cmd>wincmd k<CR>", { desc = "Go to upper window" })
map({ "n", "t" }, "<A-l>", "<Cmd>wincmd l<CR>", { desc = "Go to right window" })
map({ "n", "t" }, "<A-;>", "<Cmd>wincmd p<CR>", { desc = "Go to previous window" })

-- resize splits
map("n", "<A-H>", "<Cmd>vertical resize -3<CR>", { desc = "Decrease window width" })
map("n", "<A-L>", "<Cmd>vertical resize +3<CR>", { desc = "Increase window width" })
map("n", "<A-J>", "<Cmd>resize +3<CR>", { desc = "Increase window height" })
map("n", "<A-K>", "<Cmd>resize -3<CR>", { desc = "Decrease window height" })
