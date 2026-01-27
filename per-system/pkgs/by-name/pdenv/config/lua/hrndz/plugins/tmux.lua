-- tmux navigator
---@diagnostic disable: missing-fields
require("Navigator").setup({})
vim.keymap.set({ "n", "t" }, "<A-h>", require("Navigator").left)
vim.keymap.set({ "n", "t" }, "<A-l>", require("Navigator").right)
vim.keymap.set({ "n", "t" }, "<A-k>", require("Navigator").up)
vim.keymap.set({ "n", "t" }, "<A-j>", require("Navigator").down)
vim.keymap.set({ "n", "t" }, "<A-;>", require("Navigator").previous)

-- smart-splits
require("smart-splits").setup({
  -- Ignored buffer types (only while resizing)
  ignored_buftypes = {
    "nofile",
    "quickfix",
    "prompt",
  },
  default_amount = 3,
  disable_multiplexer_nav_when_zoomed = true,
})
-- selecting
-- https://github.com/mrjones2014/smart-splits.nvim/issues/342
-- vim.keymap.set({'n', 't'}, '<A-h>', require('smart-splits').move_cursor_left)
-- vim.keymap.set({'n', 't'}, '<A-j>', require('smart-splits').move_cursor_down)
-- vim.keymap.set({'n', 't'}, '<A-k>', require('smart-splits').move_cursor_up)
-- vim.keymap.set({'n', 't'}, '<A-l>', require('smart-splits').move_cursor_right)
-- vim.keymap.set({'n', 't'}, '<A-\\>', require('smart-splits').move_cursor_previous)

-- resizing
vim.keymap.set("n", "<A-H>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-J>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-K>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-L>", require("smart-splits").resize_right)

-- swapping
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
