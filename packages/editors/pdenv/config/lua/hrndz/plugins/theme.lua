---@param fallback? string
_G.get_colorscheme = function(fallback)
  if not vim.g.COLORS_NAME then
    vim.cmd.rshada()
  end
  if not vim.g.COLORS_NAME or vim.g.COLORS_NAME == '' then
    return fallback or 'default'
  end
  return vim.g.COLORS_NAME
end

---@param colorscheme? string
_G.save_colorscheme = function(colorscheme)
  colorscheme = colorscheme or vim.g.colors_name
  if get_colorscheme() == colorscheme then
    return
  end
  vim.g.COLORS_NAME = colorscheme
  vim.cmd.wshada()
end

vim.o.termguicolors = true
vim.cmd("syntax enable")
pcall(vim.cmd.colorscheme, get_colorscheme('rose-pine-dawn'))
-- Using before and after.
-- require("themery").setup({
--   livePreview = true,
--   themes = {
--     {
--       name = "Catppuccin Latte",
--       colorscheme = "catppuccin-latte",
--       before = [[
--       vim.opt.background = "light"
--     ]],
--     },
--     {
--       name = "Everforest",
--       colorscheme = "everforest",
--       before = [[
--       vim.opt.background = "light"
--     ]],
--     },
--     -- rose-pine/neovim
--     {
--       name = "Rose Pine",
--       colorscheme = "rose-pine",
--       before = [[
--       vim.opt.background = "light"
--     ]],
--     },
--     {
--       name = "Chocolatier",
--       colorscheme = "chocolatier",
--       before = [[
--       vim.opt.background = "light"
--     ]],
--     },
--     {
--       name = "PaperColor",
--       colorscheme = "PaperColor",
--       before = [[
--       vim.opt.background = "light"
--     ]],
--     },
--   },
-- })
--
-- local map = vim.keymap.set
-- map(
--   "n",
--   "<leader>uC",
--   "<Cmd>Themery<CR>",
--   { desc = "Colorscheme Picker" }
-- )
