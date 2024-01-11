require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { { "prettierd", "prettier" } },
    go = { "goimports", "gofumpt" },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

local map = vim.keymap.set
map(
  "n",
  "<leader>lf",
  function() require("conform").format({ async = true, lsp_fallback = true }) end,
  { desc = "Format buffer" }
)
