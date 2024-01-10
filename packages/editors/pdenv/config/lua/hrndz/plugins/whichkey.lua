local wk = require("which-key")
wk.setup({
  plugins = {
    -- marks = true, -- shows a list of your marks on ' and `
    -- registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    -- presets = {
    --   operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
    --   motions = true, -- adds help for motions
    --   text_objects = true, -- help for text objects triggered after entering an operator
    --   windows = true, -- default bindings on <c-w>
    --   nav = true, -- misc bindings to work with windows
    --   z = true, -- bindings for folds, spelling and others prefixed with z
    --   g = true, -- bindings for prefixed with g
    -- },
  },
})

-- add labels to prefixes
wk.register({
  mode = { "n", "v" },
  ["g"] = { name = "+goto" },
  ["]"] = { name = "+next" },
  ["["] = { name = "+prev" },
  ["<leader>f"] = { name = "+file/find" },
  ["<leader>b"] = { name = "+buffer" },
  ["<leader>l"] = { name = "+lsp" },
  ["<leader>w"] = { name = "+windows" },
  ["<leader>t"] = { name = "+tests" },
  ["<leader>u"] = { name = "+ui" },
  ["<leader>y"] = { name = "+clipboard" },
  ["<leader>x"] = { name = "+diagnostics/quickfix" },
})
