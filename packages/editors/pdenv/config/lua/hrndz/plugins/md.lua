require("render-markdown").setup({
  render_modes = { "n", "c" },
  file_types = { "markdown", "vimwiki" },
})

-- render-markdown
vim.keymap.set("n", "<leader>uM", function() require("render-markdown").toggle() end, { desc = "Toggle Render MD" })
