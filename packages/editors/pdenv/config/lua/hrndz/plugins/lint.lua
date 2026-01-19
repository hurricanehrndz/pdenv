require("lint").linters_by_ft = {
  go = { "golangcilint" },
  swift = { "swiftlint" },
  gitcommit = { "gitlint" },
  sh = { "shellcheck" },
  zsh = { "shellcheck" },

}

-- local golangcilint = require("lint").linters.golangcilint
-- golangcilint.append_fname = true
-- golangcilint.args = {
--   "run",
--   "--out-format",
--   "json",
--   "--fast",
-- }

local gitlint = require("lint").linters.gitlint
gitlint.stdin = true
gitlint.args = {
  "-c",
  "T1.line-length=50",
  "-c",
  "B1.line-length=72",
  "--ignore",
  "body-is-missing,T3,T5",
  "--staged",
  "--msg-filename",
  function() return vim.api.nvim_buf_get_name(0) end,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
    require("lint").try_lint("codespell")
  end,
})

local map = vim.keymap.set
map("n", "<leader>ll", function() require("lint").try_lint() end, { desc = "Lint" })
