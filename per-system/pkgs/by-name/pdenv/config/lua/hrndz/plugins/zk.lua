require("zk").setup({
  picker = "Telescope",
  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- not needed as being done by autocmd
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

local wk = require("which-key")
wk.add({
  { "<leader>zl", function() require("zk").edit({ hrefs = { "notes" } }, { title = "Zk Notes" }) end, desc = "notes" },
  { "<leader>zp", function() require("zk").edit({ hrefs = { "posts" } }, { title = "Zk Posts" }) end, desc = "posts" },
  {
    "<leader>zr",
    function() require("zk").edit({ createdAfter = "2 weeks ago", hrefs = { "notes" } }, { title = "Zk Recent" }) end,
    desc = "recent",
  },
  { "<leader>znn", function() require("zk.commands").get("ZkNew")({}) end, desc = "new note" },
  { "<leader>znp", function() require("zk.commands").get("ZkNew")({ group = "posts" }) end, desc = "new post" },
})
