local osc52 = require("osc52")
local function copy(lines, _)
  osc52.copy(table.concat(lines, "\n"))
end

local function paste()
---@diagnostic disable-next-line: param-type-mismatch
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

vim.g.clipboard = {
  name = "osc52",
  copy = { ["+"] = copy, ["*"] = copy },
  paste = { ["+"] = paste, ["*"] = paste },
}
