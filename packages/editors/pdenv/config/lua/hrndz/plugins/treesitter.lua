local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

ts_configs.setup({
  indent = { enable = true },
  highlight = {
    enable = true,

    -- list of language that will be disabled
    disable = { "bash" },

    additional_vim_regex_highlighting = false,
  },
  -- rainbow = { enable = true, disable = {} },
})
