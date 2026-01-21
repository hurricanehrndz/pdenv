return {
  cmd_env = { RUFF_TRACE = "messages" },
  init_options = {
    settings = {
      logLevel = "error",
    },
  },
  custom_setup = function()
    Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end)
  end,
}
