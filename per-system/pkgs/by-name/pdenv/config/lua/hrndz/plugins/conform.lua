require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    go = { "goimports", "gofumpt" },
    javascript = { "prettier", stop_after_first = true },
    sh = { "shfmt" },
    nix = { "nixfmt" },
    json = { "jq" },
    xml = { "xmllint" },
  },
  formatters = {
    isort = {
      condition = function(_)
        return not vim.g.conform_disable_isort
      end,
    },
    black = {
      condition = function(_)
        return not vim.g.conform_disable_black
      end,
    },
  },
})

require("conform").formatters.shfmt = {
  ptepend_args = { "-i", "4", "-ci" },
  -- The base args are { "-filename", "$FILENAME" } so the final args will be
  -- { "-i", "2", "-filename", "$FILENAME" }
}
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

local map = vim.keymap.set
map(
  "n",
  "<leader>lf",
  function() require("conform").format({ async = true, lsp_fallback = true }) end,
  { desc = "Format buffer" }
)
