require('avante_lib').load()
local baseURL = os.getenv("OPENAI_API_URL")
require("avante").setup({
  provider = "openai", -- Recommend using Claude
  -- auto_suggestions_provider = "openai", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  openai = {
    endpoint = baseURL,
    model = "sonnet-3.7",
    temperature = 0,
    max_tokens = 200000,
  },
})
