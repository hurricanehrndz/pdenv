local kind_icons = require("hrndz.icons").kinds
require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = {
    nerd_font_variant = "mono",
    kind_icons = kind_icons,
  },
  completion = {
    accept = {
      -- experimental auto-brackets support
      auto_brackets = {
        enabled = true,
      },
    },
    list = {
      selection = { preselect = false, auto_insert = true },
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
      },
      border = "rounded",
      winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
    },
    documentation = {
      window = {
        border = "rounded",
      },
    },
    ghost_text = {
      enabled = true,
    },
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      snippets = {
        opts = {
          friendly_snippets = true, -- default
          extended_filetypes = {
            sh = { "shelldoc" },
          },
        },
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  },
  cmdline = {
    enabled = true,
    keymap = { preset = "inherit" },
    completion = {
      list = { selection = { preselect = false } },
      menu = {
        auto_show = function(_) return vim.fn.getcmdtype() == ":" end,
      },
      ghost_text = { enabled = true },
    },
  },
})
