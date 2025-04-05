return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      term_colors = true,
      transparent_background = false,
      color_overrides = {
        mocha = {
          base = '#000000',
          mantle = '#000000',
          crust = '#000000',
        },
      },
    },
    priority = 1000,
  },
  {
    'EdenEast/nightfox.nvim',
    name = 'nightfox',
    priority = 1000,
    config = function()
      require('nightfox').setup {
        options = {},
        palettes = {
          carbonfox = {
            bg1 = '#000000', -- pure black to match bg0
            comment = '#d6d3d1', -- tailwind stone-300
          },
        },
        groups = {
          carbonfox = {
            -- PmenuSel = { bg = '#ff0000', fg = '#000000' },
            -- SnippetTabstop = { bg = '#ff0000', fg = '#000000' },
            -- WildMenu = { bg = '#ff0000', fg = '#000000' },
            WinSeparator = { bg = '#292524' }, -- tailwind stone-800
            LspReferenceText = { bg = '#57534e' }, -- tailwind stone-600
            LspReferenceRead = { bg = '#57534e' }, -- tailwind stone-600
            LspReferenceWrite = { bg = '#57534e' },
          },
        },
      }
    end,
  },
  {
    'rockyzhang24/arctic.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    name = 'arctic',
    -- branch = 'main',
    branch = 'v2',
    priority = 1000,
    config = function() end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
  },
}
