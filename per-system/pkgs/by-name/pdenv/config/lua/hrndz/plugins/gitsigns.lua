local gitsigns = require("gitsigns")
local wk = require("which-key")

gitsigns.setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = vim.keymap.set

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Next Change", buffer = bufnr })

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Prev Change", buffer = bufnr })

    -- Actions
    wk.add({
      {
        mode = "n",
        buffer = bufnr,
        silent = true,
        noremap = true,
        { "<leader>h", group = "+hunks" },
        { "<leader>hS", gs.stage_buffer, desc = "Stage Buffer" },
        { "<leader>hu", gs.undo_stage_hunk, desc = "Undo Stage Hunk" },
        { "<leader>hR", gs.reset_buffer, desc = "Reset Buffer" },
        { "<leader>hp", gs.preview_hunk, desc = "Preview Hunk" },
        { "<leader>hb", function() gs.blame_line({ full = true }) end, desc = "Blame Line" },
        { "<leader>hd", gs.diffthis, desc = "Diff This" },
        { "<leader>hD", function() gs.diffthis("~") end, desc = "Diff This ~" },
        { "<leader>hg", gs.toggle_deleted, desc = "View Deleted" },
        { "<leader>hs", ":Gitsigns stage_hunk<CR>", desc = "Stage Hunk" },
        { "<leader>hr", ":Gitsigns reset_hunk<CR>", desc = "Reset Hunk" },
      },
      {
        mode = "v",
        buffer = bufnr,
        silent = true,
        noremap = true,
        { "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "Stage Hunk" },
        { "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "Reset Hunk" },
      },
      -- Text object
      { mode = { "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", desc = "GitSigns Select Hunk", buffer = bufnr },
    })
  end,
})
