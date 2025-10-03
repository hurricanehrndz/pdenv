require("noice").setup({
  views = {
    cmdline_popup = {
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        min_width = 60,
        width = "auto",
        height = "auto",
      },
    },
  },
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
  },
  lsp = {
    signature = {
      auto_open = { enabled = false },
    },
  },
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

vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then return "<c-f>" end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then return "<c-b>" end
end, { silent = true, expr = true })
