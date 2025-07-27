-- tailwind-tools.lua
return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- optional
    'neovim/nvim-lspconfig', -- optional
  },
  opts = {
    document_color = {
      enabled = false, -- can be toggled by commands
      --kind = 'inline', -- "inline" | "foreground" | "background"
      kind = 'background', -- "inline" | "foreground" | "background"
      inline_symbol = '󰝤', -- only used in inline mode
      debounce = 250, -- in milliseconds, only applied in insert mode
    },
  }, -- your configuration
}
