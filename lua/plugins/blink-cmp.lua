local allowAutoComplete = function()
  local success, node = pcall(vim.treesitter.get_node)
  if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
    return false
  else
    return true
  end
end

return {
  'saghen/blink.cmp',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
      config = function()
        local luasnip = require 'luasnip'

        -- Loads all the snippets installed by extensions in vscode.
        require('luasnip.loaders.from_vscode').lazy_load()
        -- require('luasnip.loaders.from_vscode').load { paths = '~/.config/nvim/snippets' }

        luasnip.config.set_config {
          region_check_events = 'InsertEnter',
          delete_check_events = 'InsertLeave',
        }

        luasnip.config.setup {}
      end,
    },
    'folke/lazydev.nvim',
    'moyiz/blink-emoji.nvim',
  },
  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    cmdline = {
      completion = {
        ghost_text = {
          -- Ghost text looks good, but it's better to have a non-selection
          -- than a ghost selection.
          -- TODO: review
          enabled = false,
        },
        menu = {
          auto_show = true,
        },
      },
      keymap = { preset = 'inherit', ['<Tab>'] = { 'show', 'accept' } },
    },
    keymap = {
      preset = 'super-tab',
      -- ['<Tab>'] = {
      --   function(cmp)
      --     if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
      --       return cmp.accept()
      --     end
      --   end,
      --   'select_and_accept',
      -- },
      -- ['<Enter>'] = { 'select_and_accept', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
    },
    signature = { enabled = true, window = { show_documentation = false } },
    snippets = { preset = 'luasnip' },
    appearance = {
      use_nvim_cmp_as_default = true,
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        -- Whether to use treesitter highlighting, disable if you run into performance issues
        treesitter_highlighting = true,
      },
      ghost_text = {
        enabled = true,
        -- Show the ghost text when an item has been selected
        show_with_selection = true,
        -- Show the ghost text when the menu is open
        show_with_menu = true,
      },
      list = {
        selection = {
          -- When `true`, will automatically select the first item in the completion list
          preselect = true,
          auto_insert = true,
        },
        cycle = {
          -- When `true`, calling `select_next` at the _bottom_ of the completion list
          -- will select the _first_ completion item.
          from_bottom = false,
          -- When `true`, calling `select_prev` at the _top_ of the completion list
          -- will select the _last_ completion item.
          from_top = false,
        },
      },
      trigger = {
        prefetch_on_insert = true,
        -- When true, will show the completion window after typing any of
        -- alphanumerics, `-` or `_`
        show_on_keyword = true,
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'emoji' },
      -- default = function()
      --   local success, node = pcall(vim.treesitter.get_node)
      --   if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
      --     return { 'lsp' }
      --   else
      --     return { 'lsp', 'path', 'snippets', 'buffer' }
      --   end
      -- end,
      providers = {
        emoji = {
          module = 'blink-emoji',
          name = 'Emoji',
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert emoji (default) or complete its name
          should_show_items = function()
            return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
              { 'gitcommit', 'markdown' },
              vim.o.filetype
            )
          end,
        },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        -- lsp = {
        --   enabled = allowAutoComplete,
        -- },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
