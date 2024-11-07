local M = {}

M.enable_ruff = function()
  vim.g.conform_disable_isort = true
  vim.g.conform_distable_black = true
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function(opt)
      local client
      for _, item in ipairs(vim.lsp.get_clients()) do
        if item.name == "ruff" then
          client = item
          break
        end
      end
      if client then
        vim.lsp.buf_attach_client(opt.buf, client)
      else
        require("lspconfig.configs")["ruff"].launch()
      end
    end,
  })
end

return M
