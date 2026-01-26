require('smart-splits').setup({
  -- Ignored buffer types (only while resizing)
  ignored_buftypes = {
    'nofile',
    'quickfix',
    'prompt',
  },
  default_amount = 3,
  disable_multiplexer_nav_when_zoomed = true,
})


-- selecting
vim.keymap.set({'n', 't'}, '<M-h>', require('smart-splits').move_cursor_left)
vim.keymap.set({'n', 't'}, '<M-j>', require('smart-splits').move_cursor_down)
vim.keymap.set({'n', 't'}, '<M-k>', require('smart-splits').move_cursor_up)
vim.keymap.set({'n', 't'}, '<M-l>', require('smart-splits').move_cursor_right)
vim.keymap.set({'n', 't'}, '<M-\\>', require('smart-splits').move_cursor_previous)

-- resizing
vim.keymap.set('n', '<C-M-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-M-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-M-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-M-l>', require('smart-splits').resize_right)

-- swapping
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
