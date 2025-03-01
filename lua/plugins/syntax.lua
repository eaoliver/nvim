vim.keymap.set('n', '<leader>u', function()
  local result = vim.treesitter.get_captures_at_cursor(0)
  print(vim.inspect(result))
end, { noremap = true, silent = false, desc = 'Show the treesitter capture group [u]nder the cursor.' })
