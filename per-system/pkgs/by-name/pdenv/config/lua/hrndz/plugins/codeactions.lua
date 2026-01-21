require("tiny-code-action").setup({
  backend = "delta",
  picker = "snacks",
  signs = {
    quickfix = { "󰁨", { link = "DiagnosticInfo" } },
    others = { "?", { link = "DiagnosticWarning" } },
    refactor = { "", { link = "DiagnosticWarning" } },
    ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
    ["refactor.extract"] = { "", { link = "DiagnosticError" } },
    ["source.organizeImports"] = { "", { link = "TelescopeResultVariable" } },
    ["source.fixAll"] = { "", { link = "TelescopeResultVariable" } },
    ["source"] = { "", { link = "DiagnosticError" } },
    ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
    ["codeAction"] = { "", { link = "DiagnosticError" } },
  },
})
