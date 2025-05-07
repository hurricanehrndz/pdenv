require('avante_lib').load()
local endpointURL = os.getenv("OPENAI_API_URL")
require("avante").setup({
  provider = "openai", -- Recommend using Claude
  -- auto_suggestions_provider = "openai", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  openai = {
    endpoint = endpointURL,
    model = "sonnet-3.7",
    temperature = 0.7,
    max_tokens = 131072,
  },
  ["gemini-litellm"] = {
    __inherited_from = 'openai',
    endpoint = endpointURL,
    model = "gemini-2.5-pro-preview-03-25",
    temperature = 0.7,
    api_key_name = 'OPENAI_API_KEY',
  },
})
