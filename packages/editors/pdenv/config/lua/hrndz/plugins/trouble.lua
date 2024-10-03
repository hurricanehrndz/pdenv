require("trouble").setup({})

local map = vim.keymap.set
local troubleKeys = {
  {
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Diagnostics (Trouble)",
  },
  {
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    desc = "Buffer Diagnostics (Trouble)",
  },
  {
    "<leader>cs",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    desc = "Symbols (Trouble)",
  },
  {
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    desc = "LSP Definitions / references / ... (Trouble)",
  },
  {
    "<leader>xl",
    "<cmd>Trouble loclist toggle<cr>",
    desc = "Location List (Trouble)",
  },
  {
    "<leader>xq",
    "<cmd>Trouble qflist toggle<cr>",
    desc = "Quickfix List (Trouble)",
  },
}

for _, x in ipairs(troubleKeys) do
  map("n", x[1], x[2], { desc = x.desc})
end

map("n", "[q", function()
  if require("trouble").is_open() then
    require("trouble").previous({ skip_groups = true, jump = true })
  else
    local ok, err = pcall(vim.cmd.cprev)
    if not ok then vim.notify(err, vim.log.levels.ERROR) end
  end
end, { desc = "Previous trouble/quickfix item" })
map("n", "]q", function()
  if require("trouble").is_open() then
    require("trouble").next({ skip_groups = true, jump = true })
  else
    local ok, err = pcall(vim.cmd.cnext)
    if not ok then vim.notify(err, vim.log.levels.ERROR) end
  end
end, { desc = "Next trouble/quickfix item" })
