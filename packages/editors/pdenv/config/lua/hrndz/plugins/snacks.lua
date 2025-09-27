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
  lazygit = {
    -- and integrate edit with the current neovim instance
    configure = true,
    config = {
      os = { editPreset = "nvim-remote" },
      gui = {
        nerdFontsVersion = "3",
      },
    },
    theme_path = svim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
    -- Theme for lazygit
    theme = {
      [241] = { fg = "Special" },
      activeBorderColor = { fg = "MatchParen", bold = true },
      cherryPickedCommitBgColor = { fg = "Identifier" },
      cherryPickedCommitFgColor = { fg = "Function" },
      defaultFgColor = { fg = "Normal" },
      inactiveBorderColor = { fg = "FloatBorder" },
      optionsTextColor = { fg = "Function" },
      searchingActiveBorderColor = { fg = "MatchParen", bold = true },
      selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
      unstagedChangesColor = { fg = "DiagnosticError" },
    },
    win = {
      style = "lazygit",
    },
  },
})
vim.notify = notify

local map = vim.keymap.set
-- most commonly use keybinds
map("n", "<leader>ff", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>fc", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>fe", function() Snacks.explorer() end, { desc = "File Explorer" })
map("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "Notification History" })

-- Lazygit
map("n", "<C-g>", function() Snacks.lazygit() end, { desc = "Lazygit" })
-- commit in parent Git
vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=wipe'"
-- https://github.com/folke/snacks.nvim/issues/1403
local term_open_group = vim.api.nvim_create_augroup("HrndzTermOpen", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "term://*" },
  callback = function()
    local bufopts = { buffer = 0, noremap = true, silent = true }
    vim.keymap.set("t", "<esc><esc>", [[<cmd>lua vim.cmd('stopinsert')<CR>]], bufopts)
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    local term_title = vim.b.term_title
    if term_title and term_title:match("lazygit") then
      -- Create lazygit specific mappings
      vim.keymap.set("t", "<C-g>", "<cmd>close<cr>", { buffer = true })
    end
  end,
  group = term_open_group,
})

