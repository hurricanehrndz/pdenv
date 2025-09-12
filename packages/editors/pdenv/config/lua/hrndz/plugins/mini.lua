-- disable problematic keybinding
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

require("mini.misc").setup({})
require("mini.ai").setup({}) -- extended creations of a/i text objects
require("mini.align").setup({}) -- align text

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
    suffix_last = '',
    suffix_next = '',
  },
})

-- incompatible with vscode
if vim.g.vscode == nil then
  local wk = require("which-key")
  wk.add({
    mode = { "n", "v" },
    { "s", group = "+surround" },
  })
  require("mini.bufremove").setup({}) -- help deleting buffers

  local map = vim.keymap.set
  map({ "n", "v" }, "<leader>bd", function()
    local bd = require("mini.bufremove").delete
    if vim.bo.modified then
      local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
      if choice == 1 then -- Yes
        vim.cmd.write()
        bd(0)
      elseif choice == 2 then -- No
        bd(0, true)
      end
    else
      bd(0)
    end
  end, { desc = "Delete Buffer" })
  map("n", "<leader>bD", function()
    require("mini.bufremove").delete(0, true)
  end, { desc = "Delete Buffer (Force)" })
  map("n", "<leader>br", "<cmd>edit!<cr>", { desc = "Buffer Reload" })
end
