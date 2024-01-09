local osc52 = require("osc52")
local function copy(lines, _)
  osc52.copy(table.concat(lines, "\n"))
end

local function paste()
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

vim.g.clipboard = {
  name = "osc52",
  copy = { ["+"] = copy, ["*"] = copy },
  paste = { ["+"] = paste, ["*"] = paste },
}

-- copy to clipboard
local map = vim.keymap.set
map({ "n", "v" }, "<leader>yy", [["+y]], { desc = "Copy to clipboard" })
map("n", "<leader>yY", [["+Y]], { desc = "Copy line to clipboard" })
