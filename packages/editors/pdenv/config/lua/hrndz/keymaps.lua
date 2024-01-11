-- Some of the maps have been borrowed from LazyVim
-- https://sourcegraph.com/github.com/LazyVim/LazyVim@879e29504d43e9f178d967ecc34d482f902e5a91/-/blob/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set
local wk = require("which-key")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- tmux/window navigator
vim.g.tmux_navigator_no_mappings = 1
-- Ctrl+[hjkl] navigate windows
map({ "n", "t" }, "<A-h>", [[<cmd>TmuxNavigateLeft<CR>]], { desc = "Go to left window" })
map({ "n", "t" }, "<A-j>", [[<cmd>TmuxNavigateDown<CR>]], { desc = "Go to lower window" })
map({ "n", "t" }, "<A-k>", [[<cmd>TmuxNavigateUp<CR>]], { desc = "Go to upper window" })
map({ "n", "t" }, "<A-l>", [[<cmd>TmuxNavigateRight<CR>]], { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
-- map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map({ "n", "v" }, "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- location/quickfix list
local qf_list_toggle = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then qf_exists = true end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then vim.cmd("copen") end
end
local qf_list_clear = function() vim.fn.setqflist({}) end
map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
wk.register({
  ["<leader>xl"] = { "<cmd>lopen<cr>", "Location List" },
  ["<leader>xq"] = { qf_list_toggle, "Quickfix toggle" },
  ["<leader>xQ"] = { qf_list_clear, "Quickfix clear" },
  ["<leader>xu"] = { "<Cmd>UndotreeToggle<CR>", "Undotree" },
})

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go({ severity = severity }) end
end
wk.register({
  ["<leader>ld"] = { vim.diagnostic.open_float, "Line Diagnostics" },
  ["]d"] = { diagnostic_goto(true), "Next Diagnostic" },
  ["[d"] = { diagnostic_goto(false), "Prev Diagnostic" },
  ["]e"] = { diagnostic_goto(true, "ERROR"), "Next Error" },
  ["[e"] = { diagnostic_goto(false, "ERROR"), "Prev Error" },
  ["]w"] = { diagnostic_goto(true, "WARN"), "Next Warning" },
  ["[w"] = { diagnostic_goto(false, "WARN"), "Prev Warning" },
})

-- file operations
map("n", "<leader>fs", "<Cmd>update<CR>", { desc = "Save changes" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
