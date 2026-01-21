-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<M-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask about this" })
vim.keymap.set({ "n", "x" }, "<M-x>", function() require("opencode").select() end, { desc = "Select prompt" })
vim.keymap.set({ "n", "x" }, "ga", function() require("opencode").prompt("@this") end, { desc = "Add this" })
vim.keymap.set("n", "<M-.>",   function() require("opencode").toggle() end, { desc = "Toggle opencode" })
vim.keymap.set("n", "<S-C-u>",    function() require("opencode").command("messages_half_page_up") end, { desc = "Messages half page up" })
vim.keymap.set("n", "<S-C-d>",    function() require("opencode").command("messages_half_page_down") end, { desc = "Messages half page down" })

vim.g.opencode_opts = {
  provider = {
    enabled = "snacks",
    -- ---@type opencode.provider.Snacks
    -- snacks = {
    --   -- Customize `snacks.terminal` to your liking.
    -- }
  }
}
-- local esc_timer = nil
--
-- vim.api.nvim_create_augroup("OpenCodeTerminal", { clear = true })
-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	group = "OpenCodeTerminal",
-- 	callback = function()
-- 		local bufname = vim.api.nvim_buf_get_name(0)
-- 		if bufname:match("opencode$") then
--       vim.keymap.set("t", "<esc>",
--       function()
--         esc_timer = esc_timer or (vim.uv or vim.loop).new_timer()
--         if esc_timer:is_active() then
--           esc_timer:stop()
--           vim.cmd("stopinsert")
--         else
--           esc_timer:start(200, 0, function() end)
--           return "<esc>"
--         end
--       end,
--       { desc = "Double escape to normal mode", buffer = 0, expr = true })
-- 		end
-- 	end,
-- })
