-- bootstrap lazy.nvim, LazyVim and your plugins
--require("config.lazy")

--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
e   The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Pull in all the vim setup options.
require 'options'

-- Moved all the keymappings into their own file.
require 'keymaps'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Setup the Lazy package manager
require 'lazyloader'

-- Set the colour scheme
-- vim.cmd.colorscheme 'torte' -- previous mvim theme
-- vim.cmd.colorscheme 'catppuccin-mocha'
-- vim.cmd.colorscheme 'tokyonight-night'
vim.cmd.colorscheme 'carbonfox'
-- vim.cmd.colorscheme 'arctic'
vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'none' })

if vim.g.neovide then
  -- Performance debugging tool
  vim.g.neovide_profiler = false

  -- Mac keyboards don't have an alt key, so we use the command key.
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

  -- toggle fullscreen within neovide
  vim.keymap.set('n', ';f', function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = 'Toggle [f]ullscreen' })

  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_opacity = 1
  vim.g.neovide_normal_opacity = 1
  vim.g.neovide_window_blurred = false

  -- cursor
  vim.g.neovide_cursor_antialiasing = false
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_trail_size = 0

  -- animations
  vim.g.neovide_refresh_rate_idle = 250
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_scroll_animation_far_lines = 0

  -- hide the mouse when typing
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_theme = 'dark' -- dark | light | auto

  -- cursor particles
  vim.g.neovide_cursor_vfx_mode = 'railgun'

  -- Animations can be disabled as follows
  -- vim.g.neovide_position_animation_length = 0
  -- vim.g.neovide_cursor_animation_length = 0.00
  -- vim.g.neovide_cursor_trail_size = 0
  -- vim.g.neovide_scroll_animation_far_lines = 0
  -- vim.g.neovide_scroll_animation_length = 0.00
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
