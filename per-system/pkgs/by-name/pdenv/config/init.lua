-- Load nix specific configs
local has_generated_conf, generated_conf = pcall(require, "hrndz.generated")
if has_generated_conf then
    generated_conf.run()
end

-- Sensible defaults - mine
require("hrndz.options")

-- Key mappings
require("hrndz.keymaps")

-- Autocmds
require("hrndz.autocmds")

-- Plugins
require("hrndz.plugins")
