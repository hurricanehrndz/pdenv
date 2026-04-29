---@class hrndz.util.treesitter
local M = {}

M._installed = nil ---@type table<string,boolean>?
M._queries = {} ---@type table<string,boolean>

---@param lang string
function M.have_parser(lang)
  if M._installed == nil then
    M._installed = {}
  end
  if M._installed[lang] == nil then
    M._installed[lang] = vim.treesitter.language.add(lang) == true
  end
  return M._installed[lang]
end

---@param lang string
---@param query string
function M.have_query(lang, query)
  local key = lang .. ":" .. query
  if M._queries[key] == nil then
    M._queries[key] = vim.treesitter.query.get(lang, query) ~= nil
  end
  return M._queries[key]
end

---@param what string|number|nil
---@param query? string
---@overload fun(buf?:number):boolean
---@overload fun(ft:string):boolean
---@return boolean
function M.have(what, query)
  what = what or vim.api.nvim_get_current_buf()
  what = type(what) == "number" and vim.bo[what].filetype or what --[[@as string]]
  local lang = vim.treesitter.language.get_lang(what)
  if lang == nil then
    return false
  end
  if not M.have_parser(lang) then
    return false
  end
  if query and not M.have_query(lang, query) then
    return false
  end
  return true
end

function M.foldexpr()
  return M.have(nil, "folds") and vim.treesitter.foldexpr() or "0"
end

function M.indentexpr()
  return M.have(nil, "indents") and require("nvim-treesitter").indentexpr() or -1
end

return M
