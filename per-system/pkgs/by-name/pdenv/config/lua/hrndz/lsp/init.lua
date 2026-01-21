-- Setup lspconfig.
local lsp_servers = { "lua_ls", "nixd", "sourcekit", "bashls", "basedpyright", "ruff", "gopls", "terraformls" }
for _, server_name in ipairs(lsp_servers) do
  local has_opts, opts = pcall(require, "hrndz.lsp.servers." .. server_name)
  local config = has_opts and opts or {}
  local custom_setup = config.custom_setup
  local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

  local server_opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, config)
  server_opts.custom_setup = nil

  vim.lsp.config(server_name, server_opts)
  vim.lsp.enable(server_name)

  -- Run custom setup after enabling
  if custom_setup and type(custom_setup) == "function" then custom_setup(server_name, server_opts) end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then require("hrndz.lsp.keymaps").on_attach(client, buffer) end
  end,
})

Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
  vim.lsp.codelens.refresh()
  vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    buffer = buffer,
    callback = vim.lsp.codelens.refresh,
  })
end)
