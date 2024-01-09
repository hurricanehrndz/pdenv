local g = vim.g

-- Disable python plugin support
local vim_bin_path = vim.env.HOME .. "/.local/share/envs/nvim/bin"
if vim.fn.isdirectory(vim_bin_path) then
  vim.env.PATH = vim_bin_path .. ":" .. vim.env.PATH
end
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.filetype_pp = "puppet"

require("lazyvim.config.options")

g.mapleader = " "
g.maplocalleader = ","
