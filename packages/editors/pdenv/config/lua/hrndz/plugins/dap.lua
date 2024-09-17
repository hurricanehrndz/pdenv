local icons = require("hrndz.icons")
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
for name, sign in pairs(icons) do
  sign = type(sign) == "table" and sign or { sign }
  vim.fn.sign_define(
    "Dap" .. name,
    { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
  )
end

local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close({})
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close({})
-- end

-- enable virtual text
require("nvim-dap-virtual-text").setup({})
-- enable dap integration for telescope
require('telescope').load_extension('dap')

-- keybinds
local map = vim.keymap.set
local wk = require("which-key")
wk.add({
  { "<leader>d", group = "+debug" },
})
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last" })
map("n", "<leader>dx", function() require("dap").terminate() end, { desc = "Terminate" })
map("n", "<leader>dp", function() require("dap").pause() end, { desc = "Pause" })
map("n", "<leader>ds", function() require("dap").session() end, { desc = "Session" })
-- telescope
map("n", "<leader>dv", "<Cmd>Telescope dap variables<CR>", { desc = "Variables" })
map("n", "<leader>dC", "<Cmd>Telescope dap commands<CR>", { desc = "Commands" })
map("n", "<leader>df", "<Cmd>Telescope dap frames<CR>", { desc = "Frames" })
map("n", "<leader>dB", "<Cmd>Telescope dap list_breakpoints<CR>", { desc = "List Breakpoints" })
-- ui
map("n", "<leader>du", function() require("dapui").toggle({}) end, { desc = "Dap UI" })
map({ "n", "v" }, "<leader>de", function() require("dapui").eval() end, { desc = "Eval" })
map("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })

local dap_python = require("dap-python")
local codelldbPath = os.getenv("HOME") .. "/.local/share/codelldb/extension/adapter/codelldb"
dap_python.setup(vim.g.nix_dap_python)
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldbPath,
    args = {"--port", "${port}"},
  },
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.configurations.swift = dap.configurations.cpp
dap.configurations.c = dap.configurations.cpp
