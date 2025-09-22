local wk = require("which-key")
wk.setup({
  preset = "modern",
  triggers = {
    { "<auto>", mode = "nixsotc" },
    -- Auto triggers will never be created for existing keymaps (s -- subtitue). That includes every valid single key
    -- Neovim builtin mapping. If you want to trigger on a builtin keymap, you have to add it manually.
    { "s", mode = { "n", "v" } },
  },
  plugins = {
    -- marks = true, -- shows a list of your marks on ' and `
    -- registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
  },
})

-- add labels to prefixes
wk.add({
  mode = { "n", "v" },
  { "g", group = "+goto" },
  { "]", group = "+next" },
  { "[", group = "+prev" },
  { "<leader>f", group = "+file/find" },
  { "<leader>b", group = "+buffer" },
  { "<leader>l", group = "+lsp" },
  { "<leader>w", group = "+windows" },
  { "<leader>t", group = "+tests" },
  { "<leader>u", group = "+ui" },
  { "<leader>x", group = "+diagnostics/quickfix" },
  { "<leader>z", group = "+zettelkasten" },
  { "<leader>zn", group = "+new-zet" },
})
