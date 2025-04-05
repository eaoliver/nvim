return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Eviline config for lualine
    -- Author: shadmansaleh
    -- Credit: glepnir
    local lualine = require 'lualine'

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

    local function mode_display()
      local mode_map = {
        ['n'] = 'NORMAL',
        ['no'] = 'OP-PENDING',
        ['i'] = 'INSERT',
        ['ic'] = 'INSERT',
        ['ix'] = 'INSERT',
        ['v'] = 'VISUAL',
        ['V'] = 'V-LINE',
        ['\22'] = 'V-BLOCK',
        ['c'] = 'COMMAND',
        ['s'] = 'SELECT',
        ['S'] = 'S-LINE',
        ['\19'] = 'S-BLOCK',
        ['R'] = 'REPLACE',
        ['Rv'] = 'V-REPLACE',
        ['t'] = 'TERMINAL',
      }
      local abbrev_map = {
        ['n'] = 'N',
        ['no'] = 'OP',
        ['i'] = 'I',
        ['ic'] = 'I',
        ['ix'] = 'I',
        ['v'] = 'V',
        ['V'] = 'VL',
        ['\22'] = 'VB',
        ['c'] = 'C',
        ['s'] = 'S',
        ['S'] = 'SL',
        ['\19'] = 'SB',
        ['R'] = 'R',
        ['Rv'] = 'VR',
        ['t'] = 'T',
      }
      local mode = vim.api.nvim_get_mode().mode
      return vim.api.nvim_win_get_width(0) <= vim.o.columns / 2 and (abbrev_map[mode] or mode) or (mode_map[mode] or mode)
    end

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      hide_in_split = function()
        return vim.api.nvim_win_get_width(0) > vim.o.columns / 2
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local function dynamic_filename()
      -- local path_mode = vim.api.nvim_win_get_width(0) > vim.o.columns / 2 and 1 or 0 -- 1 = Relative path, 0 = Filename only
      local path_mode = vim.api.nvim_win_get_width(0) > vim.o.columns / 3 and 1 or 0 -- 1 = Relative path, 0 = Filename only
      return vim.fn.fnamemodify(vim.fn.expand '%', path_mode == 1 and ':.' or ':t')
    end

    -- Config
    local config = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        -- theme = {
        --   -- We are going to use lualine_c an lualine_x as left and
        --   -- right section. Both are highlighted by c theme .  So we
        --   -- are just setting default looks o statusline
        --   normal = { c = { fg = colors.fg, bg = colors.bg } },
        --   inactive = { c = { fg = colors.fg, bg = colors.bg } },
        -- },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = { mode_display },
        lualine_b = {
          { 'branch', color = { gui = 'bold' } },
          {
            'diff',
            -- Is it me or the symbol for modified us really weird
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.orange },
              removed = { fg = colors.red },
            },
            cond = conditions.hide_in_split,
          },
          'diagnostics',
        },
        lualine_c = {
          dynamic_filename,
        },
        lualine_x = {
          'filesize',
          {
            'o:encoding', -- option component same as &encoding in viml
            color = { gui = 'bold' },
            cond = conditions.hide_in_split,
            fmt = string.upper, -- I'm not sure why it's upper case either ;)
          },
          {
            'fileformat',
            color = { gui = 'bold' },
            cond = conditions.hide_in_split,
            fmt = string.upper,
            icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
          },
          { 'filetype', cond = conditions.hide_in_split },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          dynamic_filename,
        },
        lualine_x = {
          'filesize',
          {
            'o:encoding', -- option component same as &encoding in viml
            color = { gui = 'bold' },
            cond = conditions.hide_in_split,
            fmt = string.upper, -- I'm not sure why it's upper case either ;)
          },
          {
            'fileformat',
            color = { gui = 'bold' },
            cond = conditions.hide_in_split,
            fmt = string.upper,
            icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
          },
          { 'filetype', cond = conditions.hide_in_split },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = { 'neo-tree', 'quickfix' },
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
