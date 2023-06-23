-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

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

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)

local has_feline, _ = pcall(require, "feline")
if not has_feline then
  return
end


local vi_mode_colors = {
  NORMAL = colors.green,
  INSERT = colors.red,
  VISUAL = colors.magenta,
  OP = colors.green,
  BLOCK = colors.blue,
  REPLACE = colors.violet,
  ["V-REPLACE"] = colors.violet,
  ENTER = colors.cyan,
  MORE = colors.cyan,
  SELECT = colors.orange,
  COMMAND = colors.green,
  SHELL = colors.green,
  TERM = colors.green,
  NONE = colors.yellow,
}

local function file_osinfo()
  local os = vim.bo.fileformat:upper()
  local icon
  if os == "UNIX" then
    icon = " "
  elseif os == "MAC" then
    icon = " "
  else
    icon = " "
  end
  return icon .. os
end

local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")

local lsp_get_diag = function(severity)
  local count = lsp.get_diagnostics_count(severity)
  return (count > 0) and " " .. count .. " " or ""
end

-- LuaFormatter off

local comps = {
  vi_mode = {
    left = {
      provider = function()
        return " " .. vi_mode_utils.get_vim_mode() .. " "
      end,
      hl = function()
        return {
          name = vi_mode_utils.get_mode_highlight_name(),
          bg = vi_mode_utils.get_mode_color(),
          fg = colors.bg,
          style = "bold",
        }
      end,
      right_sep = " ",
    },
    right = {
      provider = " ",
      hl = function()
        return {
          name = vi_mode_utils.get_mode_highlight_name(),
          bg = vi_mode_utils.get_mode_color(),
          fg = colors.bg,
          style = "bold",
        }
      end,
      left_sep = " ",
      right_sep = " ",
    },
  },
  file = {
    info = {
      provider = {
        name = "file_info",
        opts = {
          file_modified_icon = "",
          type = "unique",
        },
      },
      hl = {
        fg = colors.blue,
        style = "bold",
      },
    },
    encoding = {
      provider = "file_encoding",
      left_sep = " ",
      hl = {
        fg = colors.violet,
        style = "bold",
      },
    },
    type = {
      provider = "file_type",
    },
    os = {
      provider = file_osinfo,
      left_sep = " ",
      hl = {
        fg = colors.violet,
        style = "bold",
      },
    },
    position = {
      provider = "position",
      left_sep = " ",
      hl = {
        fg = colors.cyan,
        -- style = 'bold'
      },
    },
  },
  line_percentage = {
    provider = "line_percentage",
    left_sep = " ",
    hl = {
      style = "bold",
    },
  },
  scroll_bar = {
    provider = "scroll_bar",
    left_sep = " ",
    hl = {
      fg = colors.blue,
      style = "bold",
    },
  },
  diagnos = {
    err = {
      -- provider = 'diagnostic_errors',
      provider = function()
        return "" .. lsp_get_diag(vim.diagnostic.severity.ERROR)
      end,
      -- left_sep = ' ',
      enabled = function()
        return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
      end,
      hl = {
        fg = colors.red,
      },
    },
    warn = {
      -- provider = 'diagnostic_warnings',
      provider = function()
        return "" .. lsp_get_diag(vim.diagnostic.severity.WARN)
      end,
      -- left_sep = ' ',
      enabled = function()
        return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
      end,
      hl = {
        fg = colors.yellow,
      },
    },
    info = {
      -- provider = 'diagnostic_info',
      provider = function()
        return "" .. lsp_get_diag(vim.diagnostic.severity.INFO)
      end,
      -- left_sep = ' ',
      enabled = function()
        return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
      end,
      hl = {
        fg = colors.blue,
      },
    },
    hint = {
      -- provider = 'diagnostic_hints',
      provider = function()
        return "" .. lsp_get_diag(vim.diagnostic.severity.HINT)
      end,
      -- left_sep = ' ',
      enabled = function()
        return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
      end,
      hl = {
        fg = colors.cyan,
      },
    },
  },
  lsp = {
    name = {
      provider = "lsp_client_names",
      -- left_sep = ' ',
      right_sep = " ",
      icon = "  ",
      hl = {
        fg = colors.yellow,
      },
    },
  },
  git = {
    branch = {
      provider = "git_branch",
      icon = " ",
      left_sep = " ",
      hl = {
        fg = colors.violet,
        style = "bold",
      },
    },
    add = {
      provider = "git_diff_added",
      hl = {
        fg = colors.green,
      },
    },
    change = {
      provider = "git_diff_changed",
      hl = {
        fg = colors.orange,
      },
    },
    remove = {
      provider = "git_diff_removed",
      hl = {
        fg = colors.red,
      },
    },
  },
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
-- table.insert(components.inactive[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info)
table.insert(components.active[3], comps.diagnos.err)
table.insert(components.active[3], comps.diagnos.warn)
table.insert(components.active[3], comps.diagnos.hint)
table.insert(components.active[3], comps.diagnos.info)
table.insert(components.active[3], comps.lsp.name)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.scroll_bar)
table.insert(components.active[3], comps.vi_mode.right)

-- TreeSitter
-- local ts_utils = require("nvim-treesitter.ts_utils")
-- local ts_parsers = require("nvim-treesitter.parsers")
-- local ts_queries = require("nvim-treesitter.query")
--[[ table.insert(components.active[2], {
  provider = function()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    return ("%d:%s [%d, %d] - [%d, %d]")
      :format(node:symbol(), node:type(), node:range())
  end,
  enabled = function()
    local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
    return ok and ts_parsers.has_parser()
  end
}) ]]

-- require'feline'.setup {}
require("feline").setup({
  colors = { bg = colors.bg, fg = colors.fg },
  components = components,
  vi_mode_colors = vi_mode_colors,
  force_inactive = {
    filetypes = {
      "packer",
      "NvimTree",
      "fugitive",
      "fugitiveblame",
    },
    buftypes = { "terminal" },
    bufnames = {},
  },
})

