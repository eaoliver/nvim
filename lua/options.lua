-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 0

--
-- Settings from my init.vim file
--

-- backup, swap and undo
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = false
vim.opt.autoread = true

-- indent
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true -- converts tabs to white space
vim.opt.shiftwidth = 4 -- width for autoindents
vim.opt.tabstop = 4 -- number of columns occupied by a tab
vim.opt.autoindent = true -- indent a new line the same amount as the line just typed
vim.opt.softtabstop = 2 -- see multiple spaces as tabstops so <BS> does the right thing

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.smartcase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term

-- sign column
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'

-- status and tab bar
vim.opt.laststatus = 2
-- vim.opt.laststatus = 3 -- only show a single status line
vim.opt.showmode = false
vim.opt.showtabline = 1 -- show tabline if there is more than 1 tab
vim.opt.termguicolors = true

-- get bash-like tab completions
vim.opt.wildmode = 'longest,list,full'
-- show matching
vim.opt.showmatch = true
-- set an 80 column border for good coding style
vim.opt.colorcolumn = '80'
-- Se the text width to 80 characters.
vim.opt.textwidth = 80
vim.opt.wrap = true

-- ignore some files for filename completion
vim.opt.wildignore = '*.o,*.r,*.so,*.sl,*.tar,*.tgz'

--
-- Set the default font and size
--
local default_font = 'Inconsolata'
local default_size = 14
local font_size = default_size

-- Function to update font size
local function set_font(size)
  font_size = size
  vim.opt.guifont = string.format('%s:h%d', default_font, font_size)
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
