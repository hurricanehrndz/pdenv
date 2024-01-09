local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)

require("neotest").setup({
  adapters = {
    require("neotest-go"),
  },
})

local map = require("hrndz.utils").map
map("n", "<leaer>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, "Run File")
map("n", "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, "Run All Test Files")
map("n", "<leader>tr", function() require("neotest").run.run() end, "Run Nearest")
map("n", "<leader>ts", function() require("neotest").summary.toggle() end, "Toggle Summary")
map("n", "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, "Show Output")
map("n", "<leader>tO", function() require("neotest").output_panel.toggle() end, "Toggle Output Panel")
map("n", "<leader>tS", function() require("neotest").run.stop() end, "Stop")
