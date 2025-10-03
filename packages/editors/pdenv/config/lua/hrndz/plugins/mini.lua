-- disable problematic keybinding -- substitute
vim.keymap.set({ "n", "x" }, "s", "<Nop>")

require("mini.misc").setup({})
require("mini.ai").setup({})          -- extended creations of a/i text objects
require("mini.indentscope").setup({}) -- extended creations of a/i text objects
require("mini.align").setup({})       -- align text
require("mini.icons").setup({})
require("mini.icons").mock_nvim_web_devicons()
vim.g.miniindentscope_disable = true

require("mini.surround").setup({
  mappings = {
    add = "sa",            -- Add surrounding in Normal and Visual modes
    delete = "sd",         -- Delete surrounding
    find = "sf",           -- Find surrounding (to the right)
    find_left = "sF",      -- Find surrounding (to the left)
    highlight = "sh",      -- Highlight surrounding
    replace = "sr",        -- Replace surrounding
    update_n_lines = "sn", -- Update `n_lines`

    -- disable extended mappings
    suffix_last = "",
    suffix_next = "",
  },
})

-- incompatible with vscode
if vim.g.vscode == nil then
  local wk = require("which-key")
  wk.add({
    mode = { "n", "v" },
    { "s", group = "+surround" },
    -- Add the mini.surround mapping to the which-key menu
    { "sa", desc = "Add surrounding" },
    { "sd", desc = "Delete surrounding" },
    { "sf", desc = "Find surrounding (to the right)" },
    { "sF", desc = "Find surrounding (to the left)" },
    { "sh", desc = "Highlight surrounding" },
    { "sr", desc = "Replace surrounding" },
    { "sn", desc = "Update n_lines" },
  })
end
