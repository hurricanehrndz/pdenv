require("lint").linters_by_ft = {
  go = { "revive" },
  swift = { "swiftlint" },
}

-- local golangcilint = require("lint").linters.golangcilint
-- golangcilint.append_fname = true
-- golangcilint.args = {
--   "run",
--   "--out-format",
--   "json",
-- }

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function() require("lint").try_lint() end,
})

local map = vim.keymap.set
map("n", "<leader>ll", function() require("lint").try_lint() end, { desc = "Lint" })
