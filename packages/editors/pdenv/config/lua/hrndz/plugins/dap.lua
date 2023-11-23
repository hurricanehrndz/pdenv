local has_dap, dap = pcall(require, "dap")

if not has_dap then
  return
end

local signs = {
  breakpoint = {
    text = "🧘",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  breakpoint_rejected = {
    text = "",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "🏃",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}
vim.fn.sign_define("DapBreakpoint", signs.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", signs.breakpoint_rejected)
vim.fn.sign_define("DapStopped", signs.stopped)

local has_dapui, dapui = pcall(require, "dapui")
if not has_dapui then
  return
end

require("dapui").setup()
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
local has_dap_virtual_txt, dap_virtual_txt = pcall(require, "nvim-dap-virtual-text")
if has_dap_virtual_txt then
  dap_virtual_txt.setup({})
end

-- keybinds
local map = require("hrndz.utils").map

map("n", "<space>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint")
map("n", "<space>dc", "<Cmd>lua require'dap'.continue()<CR>", "Continue")
map("n", "<space>dC", "<Cmd>Telescope dap commands<CR>", "Commands")
map("n", "<space>df", "<Cmd>Telescope dap frames<CR>", "Frames")
map("n", "<space>dB", "<Cmd>Telescope dap list_breakpoints<CR>", "Breakpoints")
map("n", "<space>dv", "<Cmd>Telescope dap variables<CR>", "Variables")
map("n", "<space>di", "<Cmd>lua require'dap'.step_into()<CR>", "Into")
map("n", "<space>do", "<Cmd>lua require'dap'.step_over()<CR>", "Over")
map("n", "<space>dO", "<Cmd>lua require'dap'.step_out()<CR>", "Out")
map("n", "<space>dr", "<Cmd>lua require'dap'.repl.toggle()<CR>", "Repl")
map("n", "<space>dl", "<Cmd>lua require'dap'.run_last()<CR>", "Last")
map("n", "<space>du", "<Cmd>lua require'dapui'.toggle()<CR>", "UI")
map("n", "<space>dx", "<Cmd>lua require'dap'.terminate()<CR>", "Exit")

local dap_python = require("dap-python")
dap_python.setup(vim.g.nix_dap_python)
-- dap.adapters.codelldb = {
--   type = "server",
--   port = "''${port}",
--   executable = {
--     command = vim.g.nix_codelldb_bin,
--     args = {
--       "--port",
--       "''${port}",
--       "--liblldb",
--       -- TODO: fix for linux
--       "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB",
--     },
--   },
-- }
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "''${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.configurations.swift = dap.configurations.cpp
