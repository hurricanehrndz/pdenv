local function find_plugin_in_rtp(basename)
  for _, p in ipairs(vim.api.nvim_list_runtime_paths()) do
    if vim.fs.basename(p) == basename then
      return p
    end
  end
  return basename
end

require("lazydev").setup({
  library = {
    { path = find_plugin_in_rtp("snacks-nvim-folke"), words = { "Snacks" } },
    { path = find_plugin_in_rtp("wezterm-types-DrKJeff16"), mods = { "wezterm"} },
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
