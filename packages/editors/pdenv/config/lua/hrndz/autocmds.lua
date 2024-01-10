---@diagnostic disable: assign-type-mismatch
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local help_files = augroup("HelpFiles", { clear = true })
autocmd("Filetype", {
  pattern = { "help" },
  callback = function()
    local bufopts = { buffer = 0, noremap = true, silent = true }
    local nvo = { "n", "v", "o" }
    vim.keymap.set(nvo, "<C-c>", [[<cmd>q<CR>]], bufopts)
    vim.keymap.set(nvo, "q", [[<cmd>q<CR>]], bufopts)
  end,
  group = help_files,
})

local spell_enabled_files = augroup("SpellingEnabledFiles", { clear = true })
autocmd("Filetype", {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en"
  end,
  group = spell_enabled_files,
})

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- no folding if buffer is bigger then 1 mb
-- see: https://github.com/nvim-treesitter/nvim-treesitter/issues/1100
local CustomFoldingExpr = augroup("CustomFoldingExpr", {})
autocmd("BufReadPre", {
  group = CustomFoldingExpr,
  pattern = "*",
  callback = function(e)
    local ok, size = pcall(vim.fn.getfsize, vim.api.nvim_buf_get_name(e.buf))
    local has_parser = pcall(vim.treesitter.get_parser, e.buf)
    if not ok or size > 1024 * 1024 then
      -- fallback to default values
      vim.opt.foldmethod = "manual"
      vim.opt.foldexpr = "0"
      vim.opt.foldlevel = 0
      vim.opt.foldtext = "foldtext()"
    elseif has_parser then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldlevel = 99
      vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
    else
      vim.opt.foldmethod = "indent"
    end
  end,
})
