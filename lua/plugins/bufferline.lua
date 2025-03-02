return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      mode = 'tabs', -- Set to "tabs" to show only tab pages instead of buffers
      diagnostics = 'nvim_lsp',
      max_name_length = 24,
      max_prefix_length = 16, -- prefix used when a buffer is de-duplicated
      truncate_names = true, -- whether or not tab names should be truncated
      tab_size = 24,
      separator_style = 'thick', -- Alternative: "thin", "thick", "padded_slant"
      show_buffer_close_icons = false,
      show_close_icon = false,
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      diagnostics_indicator = function(count, level, _, _)
        local icon = level:match 'error' and ' ' or ' ' -- Error or Warning icons
        return ' ' .. icon .. count
      end,
      offsets = {
        { filetype = 'neo-tree', text = 'File Explorer', highlight = 'Directory', text_align = 'center' },
      },
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' },
      },
    },
  },
}
