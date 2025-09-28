require("noice").setup({
  routes = {
    -- https://github.com/folke/noice.nvim/issues/1097
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
    -- lazyvim -- https://sourcegraph.com/github.com/LazyVim/LazyVim/-/blob/lua/lazyvim/plugins/ui.lua?L206
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
})
