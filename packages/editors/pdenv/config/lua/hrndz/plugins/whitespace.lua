vim.g.better_whitespace_filetypes_blacklist = {
  "",
  "diff",
  "git",
  "qf",
  "gitcommit",
  "unite",
  "help",
  "markdown",
  "fugitive",
  "toggleterm",
}
vim.g.strip_only_modified_lines = 1
vim.g.better_whitespace_enabled = 1
vim.keymap.set("n", "<leader>fW", "<Cmd>StripWhitespace<CR>", { desc = "Trim whitespace" })
