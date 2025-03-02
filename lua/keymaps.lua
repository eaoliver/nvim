-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- My keybindings to move around
vim.keymap.set('n', ',', '<C-w><S-w>', { noremap = true, desc = 'Move focus to leftward window' })
vim.keymap.set('n', '.', '<C-w><C-w>', { noremap = true, desc = 'Move focus to rightward window' })

-- I like being able to toggle highlighting
vim.keymap.set('n', ';h', ':set hls! <CR>', { desc = 'Toggle [h]ighlighting' })

-- vim.keymap.set('n', ';d', ':lua vim.diagnostic.enable(not vim.diagnostic.is_enabled()) <CR>', { noremap = true, desc = 'Toggle [d]iagnostics' })
vim.keymap.set('n', ';d', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle [d]iagnostics' })

-- I don't like how neovim added character and line deletions into the register.
-- This causes and standard copy and paste register to be overwritten, which
-- is annoying.
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, 'd', '"_d')

-- I prefer to use U for redo
vim.keymap.set('n', 'U', '<C-r>', { noremap = true, desc = 'Redo' })

-- Tabs
-- vim.keymap.set({ 'i', 'n' }, '<D-w>', function()
--   confirm_close_tab()
-- end) -- close tab
-- vim.keymap.set({ 'i', 'n' }, '<D-[>', function()
--   vim.cmd 'BufferPrevious'
-- end) -- previous tab
-- vim.keymap.set({ 'i', 'n' }, '<D-]>', function()
--   vim.cmd 'BufferNext'
-- end) -- next tab
-- vim.keymap.set('i', '<D-t>', '<C-o>:tabnew<CR><Esc>') -- new tab (insert)
-- vim.keymap.set('n', '<D-t>', ':tabnew<CR>') -- new tab (insert)

--
-- Setup cut and paste support in neovide and neovim
--
if vim.g.neovide then
  -- Select all binding
  vim.keymap.set('n', '<D-a>', 'ggVG', { noremap = true, desc = 'Select all' })
  vim.keymap.set('i', '<D-a>', '<Esc>ggVG', { noremap = true, desc = 'Select all' })

  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('i', '<D-s>', '<C-o>:w<CR>') -- Save

  vim.keymap.set('x', '<D-x>', '"+dm0i<Esc>`0') -- cut (include insert hack to fix whichkey issue #518)
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+p') -- Paste normal mode
  -- vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
  -- vim.keymap.set('i', '<D-v>', '<C-r><C-o>+', { noremap = true }) -- Also appears to work
  vim.keymap.set('v', '<D-v>', '"+p') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+', { silent = false }) -- Paste command mode
  -- MacOS specific paste funciton
  -- vim.keymap.set({ 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }, '<D-v>', function()
  --   vim.api.nvim_paste(vim.fn.getreg '+', true, -1)
  -- end, { noremap = true, silent = true })
end

-- Allow clipboard copy paste in neovim
-- vim.api.nvim_set_keymap('', '<D-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
-- vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+Pi') -- Paste terminal mode
vim.keymap.set('t', '<D-v>', [[<C-\><C-N>"+P]]) -- from https://github.com/neovide/neovide/pull/2101
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<D-v>', '<cmd>lua PasteWithoutFormatOptions()<CR>', { noremap = true, silent = true })

function PasteWithoutFormatOptions()
  local fo = vim.o.formatoptions
  vim.o.formatoptions = fo:gsub('[ro]', '') -- Remove 'r' and 'o' from formatoptions
  vim.cmd 'normal! "*p' -- Paste from the system clipboard in visual mode
  vim.o.formatoptions = fo -- Restore formatoptions
end
