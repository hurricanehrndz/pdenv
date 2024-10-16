local telescope = require("telescope")
-- override built-in filetypes
local plenary_ft = require("plenary.filetype")
plenary_ft.add_file("defs")

telescope.setup({
  extensions = {
    file_browser = {
      initial_mode = "normal",
      layout_strategy = "horizontal",
      -- sorting_strategy = "ascending",
      layout_config = {
        mirror = false,
        height = 0.9,
        -- prompt_position = "top",
        width = 0.9,
        preview_width = 0.6,
      },
    },
  },
  defaults = {
    prompt_prefix = "  ",
    selection_caret = " ",
    layout_config = {
      preview_cutoff = 40,
      width = 0.95,
      height = 0.95,
      preview_width = 0.6,
      -- prompt_position = "top",
    },
    border = true,
    -- sorting_strategy = "ascending",
    path_display = {
      truncate = 3
    },
  },
})

-- telescope.load_extension("fzf")
telescope.load_extension("file_browser")

local file_browser = function()
  ---@diagnostic disable-next-line: param-type-mismatch
  telescope.extensions.file_browser.file_browser({ path = vim.fn.expand("%:p:h", false, false) })
end

local wk = require("which-key")
wk.add({
  { "<leader>fw", desc = "+word" },
})
local map = vim.keymap.set
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, {desc = "Find Files"})
map("n", "<leader>fp", builtin.git_files, {desc = "Find Git Files"})
map("n", "<leader>fb", builtin.buffers, {desc = "Find Buffers"})
map("n", "<leader>fg", builtin.live_grep, {desc = "Live Grep"})
map("n", "<leader>fh", builtin.help_tags, {desc = "Find Help"})
map("n", "<leader>fww", builtin.grep_string, {desc = "Find Word"})
map("n", "<leader>fc", builtin.command_history, {desc = "Find Recent Commands"})
map("n", "<leader>fr", builtin.oldfiles, {desc = "Find Recent Files"})
map("n", "<leader>fe", file_browser, {desc = "Open explorer"})
map("n", "<leader>fn", "<cmd>Telescope notify<CR>", { desc = "Find recent Notifications"})

-- primeagen
map("n", "<leader>fwc", function()
  local word = vim.fn.expand("<cword>")
  builtin.grep_string({ search = word })
end, { desc = "Find cword"})
map("n", "<leader>fwC", function()
  local word = vim.fn.expand("<cWORD>")
  builtin.grep_string({ search = word })
end, { desc = "Find cWORD"})
