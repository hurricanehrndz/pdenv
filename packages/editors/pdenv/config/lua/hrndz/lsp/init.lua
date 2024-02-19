-- Setup lspconfig.
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local has_lsplines, lsp_lines = pcall(require, "lsp_lines")

if not has_cmp then return end

if has_lsplines then
  lsp_lines.setup()
  vim.keymap.set("n", "<space>ll", require("lsp_lines").toggle, { desc = "Toggle lsp lines" })
end

require("neodev").setup({
  override = function(root_dir, library)
    if require("neodev.util").has_file(root_dir, "packages/editors/pdenv/default.nix") then
      library.enabled = true
      library.plugins = true
    end
  end,
})

local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  has_cmp and cmp_nvim_lsp.default_capabilities() or {}
)

local lsp_servers = { "lua_ls", "rnix", "sourcekit", "bashls", "pyright", "gopls", "terraformls", "ruff_lsp" }
for _, server_name in ipairs(lsp_servers) do
  local has_opts, opts = pcall(require, "hrndz.lsp.servers." .. server_name)
  local server_opts =
    vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities) }, has_opts and opts or {})
  require("lspconfig")[server_name].setup(server_opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- enable capabilities based on available server capabilities
    require("hrndz.lsp.caps").on_attach(client, bufnr)
    -- setup lsp keymaps
    require("hrndz.lsp.keymaps").on_attach(client, bufnr)
  end,
})

local signs = require("hrndz.icons").diagnostics
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = {
    prefix = "●",
  },
  virtual_lines = false,
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = false,
  },
  update_in_insert = false, -- default to false
  severity_sort = true, -- default to false
})

require("lspsaga").setup({
  -- symbol_in_winbar = {
  --   enable = false;
  -- },
  lightbulb = {
    enable = false;
  }
})
require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "rounded",
  },
  floating_window = false,
  toggle_key = '<C-k>'
})
