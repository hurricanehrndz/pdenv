require("todo-comments").setup({})

local map = vim.keymap.set
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
map("n", "<leader>st", function() Snacks.picker.pick("todo_comments") end, { desc = "Todo" })
map(
  "n",
  "<leader>sT",
  function() Snacks.picker.pick("todo_comments", { keywords = { "TODO", "FIX", "FIXME" } }) end,
  { desc = "Todo/Fix/Fixme" }
)
map("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
map("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme (Trouble)" })
