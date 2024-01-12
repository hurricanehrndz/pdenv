if vim.g.vscode == nil then
  require("hrndz.plugins.whitespace")
  require("hrndz.plugins.alpha")
  require("hrndz.plugins.theme")
  require("hrndz.plugins.whichkey")
  require("hrndz.plugins.fidget")
  require("hrndz.plugins.gitsigns")
  require("colorizer").setup()
  require("nvim-web-devicons").setup({ defualt = true })
  require("hrndz.plugins.telescope")
  require("hrndz.plugins.treesitter")
  require("hrndz.plugins.toggleterm")
  require("hrndz.plugins.winpicker")
  require("hrndz.plugins.osc52")
  require("hrndz.plugins.diffview")
  require("hrndz.plugins.conform")
  require("hrndz.plugins.lint")

  require("hrndz.plugins.trouble")
  require("hrndz.plugins.completion")
  require("hrndz.lsp")

  require("hrndz.plugins.statusline")
  require("hrndz.plugins.dap")
  -- merge conflicts
  require("diffview").setup({})

  require("hrndz.plugins.neotest")
end

-- text manipulation
require("hrndz.plugins.mini")
