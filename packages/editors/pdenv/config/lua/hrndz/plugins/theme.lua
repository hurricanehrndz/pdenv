---@param fallback? string
_G.get_colorscheme = function(fallback)
  if not vim.g.COLORS_NAME then
    pcall(vim.cmd.rshada)
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
