vim.o.termguicolors = true
vim.cmd("syntax enable")
-- Using before and after.
require("themery").setup({
  livePreview = true,
  themes = {
    {
      name = "Catppuccin Latte",
      colorscheme = "catppuccin-latte",
      before = [[
      vim.opt.background = "light"
    ]],
    },
    {
      name = "Everforest",
      colorscheme = "everforest",
      before = [[
      vim.opt.background = "light"
    ]],
    },
    -- rose-pine/neovim
    {
      name = "Rose Pine",
      colorscheme = "rose-pine",
      before = [[
      vim.opt.background = "light"
    ]],
    },
    {
      name = "Chocolatier",
      colorscheme = "chocolatier",
      before = [[
      vim.opt.background = "light"
    ]],
    },
    {
      name = "PaperColor",
      colorscheme = "PaperColor",
      before = [[
      vim.opt.background = "light"
    ]],
    },
  },
})

local map = vim.keymap.set
map(
  "n",
  "<leader>ut",
  "<Cmd>Themery<CR>",
  { desc = "Theme picker" }
)
