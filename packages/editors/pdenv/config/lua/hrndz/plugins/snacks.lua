local notify = vim.notify
require("snacks").setup({
  bigfile = {
    enabled = true,
  },
  dashboard = {
    enabled = true,
    preset = {
      pick = nil,
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
    sections = {
      { section = "header" },
      {
        pane = 2,
        section = "terminal",
        cmd = "colorscript -e square",
        height = 5,
        padding = 1,
      },
      { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      { section = "keys", gap = 1, padding = 1 },
      {
        pane = 2,
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function() return Snacks.git.get_root() ~= nil end,
        cmd = "git status --short --branch --renames",
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
      },
    },
  },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  input = {
    enabled = true,
  },
  explorer = {
    enabled = true,
    replace_netrw = true,
  },
  picker = {
    enabled = true,
    sources = {
      -- https://www.reddit.com/r/neovim/comments/1mvlp86/lazyvim_snacks_picker_how_to_turn_on_preview/
      notifications = {
        win = {
          preview = {
            wo = {
              wrap = true,
            },
          },
        },
      },
    },
  },
  image = {
    enabled = true,
  },
})
vim.notify = notify

local map = vim.keymap.set
-- most commonly use keybinds
map("n", "<leader>ff", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>f/", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>fc", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>fe", function() Snacks.explorer() end, { desc = "File Explorer" })
map("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "Notification History" })

-- more find
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })

-- Buffers
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })

-- scartch butter
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

-- toggles
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
  :map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
-- cause an error when deleted -- check lazyvim distro for treesitter settings
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.inlay_hints():map("<leader>uh")

-- git
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
map({ "n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
end, { desc = "Git Browse (copy)" })
