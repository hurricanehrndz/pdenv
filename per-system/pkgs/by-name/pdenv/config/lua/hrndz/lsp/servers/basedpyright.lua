return {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard", -- options: "off", "basic", "standard", "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}
