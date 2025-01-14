if vim.g.vscode then
  require("vscode").notify('Running in vscode')
end

if vim.g.vscode == nil then
  require("hrndz.plugins.treesitter")
  require("hrndz.plugins.whitespace")
  require("hrndz.plugins.alpha")
  require("hrndz.plugins.theme")
  require("hrndz.plugins.whichkey")
  require("hrndz.plugins.fidget")
  require("hrndz.plugins.gitsigns")
  require("colorizer").setup()
  require("nvim-web-devicons").setup({ default = true })
  require("Comment").setup()
  require("hrndz.plugins.telescope")
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
  require("hrndz.plugins.actionspreview")
  require("hrndz.plugins.endhints")
  -- merge conflicts
  require("diffview").setup({})

  require("hrndz.plugins.neotest")
  require("hrndz.plugins.md")
  require("hrndz.plugins.zk")
  require("hrndz.plugins.avante")
  require("hrndz.plugins.copilot")
end

-- if vim.g.vscode then require("lsp-endhints").setup({
--   autoEnableHints = false,
-- }) end

-- text manipulation
require("hrndz.plugins.mini")
