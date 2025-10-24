-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask about this" })
vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select prompt" })
vim.keymap.set({ "n", "x" }, "<leader>o+", function() require("opencode").prompt("@this") end, { desc = "Add this" })
vim.keymap.set("n", "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle embedded" })
vim.keymap.set("n", "<leader>oc", function() require("opencode").command() end, { desc = "Select command" })
vim.keymap.set("n", "<leader>on", function() require("opencode").command("session_new") end, { desc = "New session" })
vim.keymap.set("n", "<leader>oi", function() require("opencode").command("session_interrupt") end, { desc = "Interrupt session" })
vim.keymap.set("n", "<leader>oA", function() require("opencode").command("agent_cycle") end, { desc = "Cycle selected agent" })
vim.keymap.set("n", "<S-C-u>",    function() require("opencode").command("messages_half_page_up") end, { desc = "Messages half page up" })
vim.keymap.set("n", "<S-C-d>",    function() require("opencode").command("messages_half_page_down") end, { desc = "Messages half page down" })

local esc_timer = nil

vim.api.nvim_create_augroup("OpenCodeTerminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	group = "OpenCodeTerminal",
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname:match("opencode$") then
      vim.keymap.set("t", "<esc>",
      function()
        esc_timer = esc_timer or (vim.uv or vim.loop).new_timer()
        if esc_timer:is_active() then
          esc_timer:stop()
          vim.cmd("stopinsert")
        else
          esc_timer:start(200, 0, function() end)
          return "<esc>"
        end
      end,
      { desc = "Double escape to normal mode", buffer = 0, expr = true })
		end
	end,
})
