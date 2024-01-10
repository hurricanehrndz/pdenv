require("trouble").setup({
  auto_fold = true,
  icons = true,
  use_diagnostic_signs = true,
})

local map = vim.keymap.set
map("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Workspace Diagnostics (Trouble)" })
map(
  "n",
  "<leader>xd",
  function() require("trouble").toggle("document_diagnostics") end,
  { desc = "Document Diagnostics (Trouble)" }
)
map("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = "Quickfix List (Trouble)" })
map("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "Location List (Trouble)" })
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
