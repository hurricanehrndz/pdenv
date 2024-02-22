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
    wk.register({
      ["<leader>h"] = { name = "+hunks" },
      ["<leader>hS"] = { gs.stage_buffer, "Stage Buffer" },
      ["<leader>hu"] = { gs.undo_stage_hunk, "Undo Stage Hunk" },
      ["<leader>hR"] = { gs.reset_buffer, "Reset Buffer" },
      ["<leader>hp"] = { gs.preview_hunk, "Preview Hunk" },
      ["<leader>hb"] = { function() gs.blame_line({ full = true }) end, "Blame Line" },
      ["<leader>hd"] = { gs.diffthis, "Diff This" },
      ["<leader>hD"] = { function() gs.diffthis("~") end, "Diff This ~" },
      ["<leader>hg"] = { gs.toggle_deleted, "View Deleted" },
    }, { mode = "n", buffer = bufnr, silent = true, noremap =  true })
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk", buffer = bufnr })
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk", buffer = bufnr })
    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk", buffer = bufnr })
  end,
})
