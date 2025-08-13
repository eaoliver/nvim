-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 0

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

--
-- Settings from my init.vim file
--

-- backup, swap and undo
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undofile = false
vim.o.autoread = true

-- indent
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.expandtab = true -- converts tabs to white space
vim.o.shiftwidth = 4 -- width for autoindents
vim.o.tabstop = 4 -- number of columns occupied by a tab
vim.o.autoindent = true -- indent a new line the same amount as the line just typed
vim.o.softtabstop = 2 -- see multiple spaces as tabstops so <BS> does the right thing

-- search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.wrapscan = true
vim.o.smartcase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term

-- sign column
vim.o.number = true
vim.o.relativenumber = false
vim.o.numberwidth = 4
vim.o.signcolumn = 'yes'

-- status and tab bar
vim.o.laststatus = 2
-- vim.o.laststatus = 3 -- only show a single status line
vim.o.showmode = false
vim.o.showtabline = 1 -- show tabline if there is more than 1 tab
vim.o.termguicolors = true

-- get bash-like tab completions
vim.o.wildmode = 'longest,list,full'
-- show matching
vim.o.showmatch = true
-- set an 80 column border for good coding style
vim.o.colorcolumn = '80'
-- Se the text width to 80 characters.
vim.o.textwidth = 80
vim.o.wrap = true

-- ignore some files for filename completion
vim.o.wildignore = '*.o,*.r,*.so,*.sl,*.tar,*.tgz'

--
-- Set the default font and size
--
local default_font = 'Inconsolata'
local default_size = 14
local font_size = default_size

-- Function to update font size
local function set_font(size)
  font_size = size
  vim.o.guifont = string.format('%s:h%d', default_font, font_size)
end

-- Increase font size
vim.keymap.set('n', '<D-=>', function()
  set_font(font_size + 1)
end, { desc = 'Increase font size by 1 point' })

-- Decrease font size
vim.keymap.set('n', '<D-->', function()
  set_font(font_size - 1)
end, { desc = 'Decrease font size by 1 point' })

-- Reset font size
vim.keymap.set('n', '<D-0>', function()
  set_font(default_size)
end, { desc = 'Reset font size' })

-- Set initial font
set_font(default_size)
