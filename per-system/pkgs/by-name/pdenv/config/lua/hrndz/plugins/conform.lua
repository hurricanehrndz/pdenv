require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    go = { "goimports", "gofumpt" },
    javascript = { "prettier", stop_after_first = true },
    typescript = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },
    sh = { "shfmt" },
    nix = { "nixfmt" },
    json = { "jq" },
    xml = { "xmllint" },
    yaml = { "yamlfmt" },
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

require("conform").formatters.jq = {
  prepend_args = { "--indent", "2" },
}
require("conform").formatters.shfmt = {
  prepend_args = { "-i", "4", "-ci" },
}
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

local map = vim.keymap.set
map(
  "n",
  "<leader>lf",
  function() require("conform").format({ async = true, lsp_fallback = true }) end,
  { desc = "Format buffer" }
)
