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
    enabled = true,
  },
  routes = {
    {
      view = "split",
      filter = { event = "msg_show", kind = { "shell_out", "shell_err" } },
      opts = {
        enter = true,
        level = "info",
        skip = false,
        replace = false,
      },
    },
    {
      view = "split",
      filter = {
        event = "msg_show",
        find = "stack traceback:",
      },
      opts = { enter = true },
    },
    {
      view = "split",
      filter = { event = "msg_show", min_height = 10 },
      opts = { enter = true },
    },
  },
  presets = {
    long_message_to_split = true,
    lsp_doc_border = true,
  },
})
