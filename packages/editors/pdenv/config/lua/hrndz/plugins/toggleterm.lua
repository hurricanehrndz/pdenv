local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then return end

-- Set git editor in toggleterm
vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=wipe'"

toggleterm.setup({
  open_mapping = nil,
  hide_numbers = true,
  direction = "float",
  close_on_exit = true,
  start_in_insert = true,
  -- can not persist, if I want to always start in insert
  persist_mode = false,
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  count = 99,
  hidden = true,
  direction = "float",
  insert_mappings = false,
  close_on_exit = true,
  persist_mode = false,
  start_in_insert = true,
  on_open = function(term)
    local map_opts = { buffer = term.bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "q", function() return vim.cmd("stopinsert") end, map_opts)
  end,
})

function LazygitToggle() lazygit:toggle() end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-g>", LazygitToggle, opts)
vim.keymap.set("t", "<C-g>", LazygitToggle, opts)

local term_open_group = vim.api.nvim_create_augroup("HrndzTermOpen", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "term://*" },
  callback = function()
    local bufopts = { buffer = 0, noremap = true, silent = true }
    vim.keymap.set("t", "<esc><esc>", [[<cmd>lua vim.cmd('stopinsert')<CR>]], bufopts)
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
  group = term_open_group,
})

local function toggleterm_toggle()
  local count = vim.v.count > 0 and vim.v.count or 1
  require("toggleterm").toggle(count)
end
vim.keymap.set({ "n", "t" }, "<C-/>", toggleterm_toggle, opts)
vim.keymap.set({ "n", "t" }, "<C-_>", toggleterm_toggle, opts)
