-- Setup lspconfig.
local lsp_servers = { "lua_ls", "nil_ls", "sourcekit", "bashls", "pyright", "gopls", "terraformls" }
for _, server_name in ipairs(lsp_servers) do
  local has_opts, opts = pcall(require, "hrndz.lsp.servers." .. server_name)
  local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)
  local server_opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, has_opts and opts or {})
  vim.lsp.config(server_name, server_opts)
  vim.lsp.enable(server_name)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then require("hrndz.lsp.keymaps").on_attach(client, buffer) end
  end,
})
