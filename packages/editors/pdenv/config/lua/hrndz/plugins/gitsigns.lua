local gitsigns = require("gitsigns")
local wk = require("which-key")

gitsigns.setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc, opts)
      opts = opts or {}
      opts.desc = desc
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', gs.next_hunk, "Next Hunk")
    map('n', '[h', gs.prev_hunk, "Prev Hunk")

    -- Actions
    wk.register({
      ["<leader>h"] = { name = "+hunks" },
      ["<leader>hS"] = { gs.stage_buffer,  "Stage Buffer"},
      ["<leader>hu"] = { gs.undo_stage_hunk, "Undo Stage Hunk"},
      ["<leader>hR"] = { gs.reset_buffer, "Reset Buffer" },
      ['<leader>hp'] = { gs.preview_hunk, "Preview Hunk" },
      ["<leader>hb"] = { function() gs.blame_line({ full = true }) end, "Blame Line" },
      ["<leader>hd"] = { gs.diffthis, "Diff This" },
      ["<leader>hD"] = { function() gs.diffthis('~') end, "Diff This ~" },
      ["<leader>hg"] = { gs.toggle_deleted, "View Deleted" }
    })
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  end
})
