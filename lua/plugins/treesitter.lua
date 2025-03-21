return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
    },
    event = { 'BufWritePre', 'BufNewFile' },
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      -- Autoinstall languages that are not installed
      auto_install = true,
      autotag = {
        enable = true,
      },
      ensure_installed = {
        'bash',
        'c',
        'csv',
        'diff',
        'dockerfile',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'html',
        'query',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'sql',
        'vim',
        'vimdoc',
      },
      highlight = {
        enable = false,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'vn',
          node_incremental = 'vn',
          scope_incremental = false,
          node_decremental = '<BS>',
        },
      },
      indent = { enable = false, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  },
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  require 'plugins.treesitter-text-objects',
}
