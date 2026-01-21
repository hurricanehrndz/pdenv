local ts_utils = require("hrndz.utils.treesitter")

---@type table<string, table<string, boolean>>
--- Example:
--- {
---   highlight = { markdown = false },
---   indent = {},
---   folds = { python = true },
--- }
local opts = {
  highlight = {},
  indent = {},
  folds = {},
}

---@param option string
---@param value any
local function set_default(option, value)
  if vim.api.nvim_get_option_value(option, { scope = "local" }) == vim.api.nvim_get_option_value(option, {}) then
    vim.opt_local[option] = value
    return true
  end
  return false
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("hrndz_treesitter", { clear = true }),
  callback = function(ev)
    local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
    if not ts_utils.have(ft) then
      return
    end

    ---@param feat string
    ---@param query string
    local function enabled(feat, query)
      local langs = opts[feat] or {}
      local is_enabled = langs[lang]
      if is_enabled == nil then
        is_enabled = true
      end
      return is_enabled and ts_utils.have(ft, query)
    end

    if enabled("highlight", "highlights") then
      pcall(vim.treesitter.start, ev.buf)
    end

    if enabled("indent", "indents") then
      set_default("indentexpr", "v:lua.require'hrndz.utils.treesitter'.indentexpr()")
    end

    if enabled("folds", "folds") then
      if set_default("foldmethod", "expr") then
        set_default("foldexpr", "v:lua.require'hrndz.utils.treesitter'.foldexpr()")
        vim.opt_local.foldlevel = 99
        vim.opt_local.conceallevel = 0
      end
    end
  end,
})
