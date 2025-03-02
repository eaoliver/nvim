local M = {}

function M.highlight(group, options)
  local opts = { bg = 'none', fg = 'none' }
  if options then
    opts = vim.tbl_extend('force', opts, options)
  end
  vim.api.nvim_set_hl(0, group, opts)
end

function M.map(mode, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

return M
