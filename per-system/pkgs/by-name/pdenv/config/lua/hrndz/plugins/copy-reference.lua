local copy_reference = require("copy-reference")
local wk = require("which-key")

copy_reference.setup()

wk.add({
  {
    mode = { "n", "v" },
    silent = true,
    noremap = true,
    { "<leader>yr", group = "+reference" },
    { "<leader>yrr",  "<cmd>CopyReference line<cr>", desc = "Copy file:line reference" },
  },
  {
    mode = { "n" },
    silent = true,
    noremap = true,
    { "<leader>yrf", "<cmd>CopyReference file<cr>", desc = "Copy file reference" },
  },
})
