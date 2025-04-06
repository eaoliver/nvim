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

-- Utility function to check if a window showing a quickfix or location list is open
function M.is_list_open(list_type)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    if vim.fn.getbufvar(bufnr, '&buftype') == 'quickfix' then
      if list_type == 'quickfix' then
        return true
      end
      if list_type == 'location' and vim.fn.getwininfo(win)[1].loclist == 1 then
        return true
      end
    end
  end
  return false
end

return M
