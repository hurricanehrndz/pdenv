require("noice").setup({
  cmdline = {
    enabled = true,
  },
  health = {
    checker = true,
  },
  notify = {
    enabled = false,
  },
  messages = {
    enabled = false,
  },
  routes = {
    {
      filter = { event = "msg_show", kind = "search_count" },
      opts = { skip = true },
    },
    {
      view = "split",
      filter = { event = "msg_show", kind = { "shell_out", "shell_err" } },
      opts = {
        level = "info",
        skip = false,
        replace = false,
      },
      {
        view = "split",
        filter = { event = "msg_show", min_height = 10 },
      },
    },
  },
  presets = {
    long_message_to_split = true,
    lsp_doc_border = true,
  },
})
