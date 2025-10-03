if vim.g.vscode then
  require("vscode").notify('Running in vscode')
end

if vim.g.vscode == nil then
  require("hrndz.plugins.noice")
  require("hrndz.plugins.snacks")
  require("hrndz.plugins.lazydev")
  require("hrndz.plugins.treesitter")
  require("hrndz.plugins.whitespace")
  require("hrndz.plugins.theme")
  require("hrndz.plugins.whichkey")
  require("hrndz.plugins.fidget")
  require("hrndz.plugins.gitsigns")
  require("colorizer").setup()
  require("Comment").setup()
  require("hrndz.plugins.winpicker")
  require("hrndz.plugins.osc52")
  require("hrndz.plugins.diffview")
  require("hrndz.plugins.conform")
  require("hrndz.plugins.lint")

  -- completion, diagnostics, actions and LSP
  require("hrndz.plugins.trouble")
  require("hrndz.diagnostics")

  require("hrndz.plugins.blink")
  require("hrndz.lsp")

  require("hrndz.plugins.statusline")
  require("hrndz.plugins.codeactions")
  require("hrndz.plugins.endhints")

  -- debugging and tests
  require("hrndz.plugins.dap")
  require("hrndz.plugins.neotest")

  -- merge conflicts
  require("diffview").setup()


  -- notes plugins
  require("hrndz.plugins.md")
  require("hrndz.plugins.zk")
end

-- text manipulation
require("hrndz.plugins.mini")
