if vim.g.vscode == nil then
  require("hrndz.plugins.alpha")
  require("hrndz.plugins.tokyonight")
  require("hrndz.plugins.indentblankline")
  require("hrndz.plugins.gitsigns")
  require("colorizer").setup()
  require("nvim-web-devicons").setup({ defualt = true })
  require("hrndz.plugins.telescope")
  require("hrndz.plugins.treesitter")
  require("hrndz.plugins.toggleterm")
  require("hrndz.plugins.winpicker")

  require("hrndz.plugins.whichkey")

  require("hrndz.plugins.trouble")
  require("hrndz.plugins.completion")
  require("hrndz.lsp")

  require("hrndz.plugins.statusline")
  require("hrndz.plugins.whitespace")
  require("hrndz.plugins.dap")
  -- merge conflicts
  require("diffview").setup({})
end

-- text manipulation
require("hrndz.plugins.comment")
require("hrndz.plugins.mini")
