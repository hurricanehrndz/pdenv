require("lazydev").setup({
  library = {
    { path = "catppuccin" },
    { path = "snacks.nvim", words = { "Snacks" } },
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
