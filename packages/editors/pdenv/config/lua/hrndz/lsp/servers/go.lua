local M = {
  setup = function(custom_on_attach, _, capabilities)
    local lspconfig = require("lspconfig")
    lspconfig.gopls.setup({
      on_attach = function(client, bufnr)
        custom_on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      settings = {
        gopls = {
          gofumpt = true,
          codelenses = {
            gc_details = true,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            fieldalignment = true,
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
            fillstruct = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
          semanticTokens = true,
        },
      },
    })
  end,
}

return M
