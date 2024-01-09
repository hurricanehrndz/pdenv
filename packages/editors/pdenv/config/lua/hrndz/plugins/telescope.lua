local telescope = require("telescope")
-- override built-in filetypes
local plenary_ft = require("plenary.filetype")
plenary_ft.add_file("defs")

telescope.setup({
  extensions = {
    file_browser = {
      initial_mode = "normal",
      layout_strategy = "horizontal",
      sorting_strategy = "ascending",
      layout_config = {
        mirror = false,
        height = 0.9,
        prompt_position = "top",
        preview_cutoff = 120,
        width = 0.9,
        preview_width = 0.55,
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
      prompt_position = "top",
    },
    border = true,
    sorting_strategy = "ascending",
    path_display = {
      truncate = 3
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

local file_browser = function()
  ---@diagnostic disable-next-line: param-type-mismatch
  telescope.extensions.file_browser.file_browser({ path = vim.fn.expand("%:p:h", false, false) })
end

local map = vim.keymap.set
map("n", "<leader>ff", require("telescope.builtin").find_files, {desc = "Find Files"})
map("n", "<leader>fp", require("telescope.builtin").git_files, {desc = "Find Git Files"})
map("n", "<leader>fb", require("telescope.builtin").buffers, {desc = "Find Buffers"})
map("n", "<leader>fg", require("telescope.builtin").live_grep, {desc = "Live Grep"})
map("n", "<leader>fh", require("telescope.builtin").help_tags, {desc = "Find Help"})
map("n", "<leader>fw", require("telescope.builtin").grep_string, {desc = "Find Word"})
map("n", "<leader>fc", require("telescope.builtin").command_history, {desc = "Find Recent Commands"})
map("n", "<leader>fr", require("telescope.builtin").oldfiles, {desc = "Find Recent Files"})
map("n", "<leader>fe", file_browser, {desc = "Open explorer"})
map("n", "<space>fn", "<cmd>Telescope notify<CR>", { desc = "Find recent Notifications"})
