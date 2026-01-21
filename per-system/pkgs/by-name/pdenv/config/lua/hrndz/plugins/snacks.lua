-- preserve noice
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
      colorschemes = {
        confirm = function(picker, item)
          vim.g.snacks_colors_confirm = true
          Snacks.picker.sources.colorschemes.confirm(picker, item)
          save_colorscheme(item.text)
        end,
        on_close = function()
          if vim.g.snacks_colors_confirm ~= true then pcall(vim.cmd.colorscheme, get_colorscheme()) end
          vim.g.snacks_colors_confirm = nil
        end,
        on_change = function(_, item)
          if item then pcall(vim.cmd.colorscheme, item.text) end
        end,
        layout = { preset = "sidebar" },
      },
    },
  },
  lazygit = {
    -- and integrate edit with the current neovim instance
    configure = true,
    config = {
      os = {
        edit = [[nvr -s -cc 'LazygitCloseFocusLargest' &&  nvr {{filename}}]],
        editAtLine = [[nvr -s -cc 'LazygitCloseFocusLargest' &&  nvr +{{line}} -- {{filename}}]],
        openDirInEditor = [[nvr -s 'LazygitCloseFocusLargest' &&  nvr {{dir}}]],
      },
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
  image = { enabled = true },
  words = { enabled = true },
  indent = { enabled = true },
  scope = { enable = true },
  statuscolumn = { enabled = true },
  terminal = {},
})
vim.notify = notify

local map = vim.keymap.set
-- Top Pickers & Explorer
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })

-- find
map("n", "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, { desc = "Find Files" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })

-- Lazygit
map({ "n", "t" }, "<C-g>", function() Snacks.lazygit() end, { desc = "Lazygit" })
-- commit in parent Git
vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=wipe'"

local function close_lazygit_focus_largest()
  local largest_window = nil
  local largest_area = 0
  local closed_count = 0

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_is_valid(win) then
      local config = vim.api.nvim_win_get_config(win)
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name:match("^term://.*lazygit$") then
        pcall(vim.api.nvim_win_close, win, false)
        closed_count = closed_count + 1
      -- ignore floating windows -- I don't edit files in floating windows
      elseif config.relative ~= "" then
      -- ignore all terminal buffers
      elseif buf_name:match("^term://.*") then
      else
        local width = vim.api.nvim_win_get_width(win)
        local height = vim.api.nvim_win_get_height(win)
        local area = width * height
        if area > largest_area then
          largest_area = area
          largest_window = win
        end
      end
    end
  end

  if largest_window and vim.api.nvim_win_is_valid(largest_window) then vim.api.nvim_set_current_win(largest_window) end
end

-- Create command for closing lazygit and focusing largest non floating buffer
vim.api.nvim_create_user_command("LazygitCloseFocusLargest", close_lazygit_focus_largest, {})

-- Terminal
map({ "n", "t" }, "<C-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map({ "n", "t" }, "<C-_>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })

-- Buffers
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>ba", function() Snacks.bufdelete.all() end,   { desc = "Buffer delete all" })
map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Buffer delete other" })

-- scratch butter
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

-- toggles
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
  :map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.inlay_hints():map("<leader>uh")

-- git
map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
map("n", "<leader>gB", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
map("n", "<leader>gh", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })

-- search
map("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
map("n", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search History" })
map("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
map("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
map("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
map("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undotree" })

-- grep
map("n", "<leader>sb", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
map("n", "<leader>sB", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })

-- ui
map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
