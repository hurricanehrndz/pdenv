-- completion settings
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect", "preview" }
-- disable insert completion menu messages, I = true -- disable intro
vim.opt.shortmess:append({ I = true, c = true, C = true })
-- completion menu height
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then return end

local has_luasnip, luasnip = pcall(require, "luasnip")
if not has_luasnip then return end

local has_lspkind, lspkind = pcall(require, "lspkind")
if not has_lspkind then return end

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

lspkind.init()
local cmp_formatting = {
  -- Youtube: How to set up nice formatting for your sources.
  fields = { "kind", "abbr", "menu" },
  format = lspkind.cmp_format({
    mode = "symbol",
    maxwidth = 50,
    menu = {
      -- copilot = "[co]",
      buffer = "[buf]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[api]",
      zsh = "[zpty]",
      path = "[path]",
      luasnip = "[snip]",
      dictionary = "[dict]",
    },
  }),
}

local cmp_keymaps = {
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-Space>"] = cmp.mapping.complete({}),
  ["<C-e>"] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  ["<C-n>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<C-p>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<c-y>"] = cmp.mapping(
    cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    { "i", "c" }
  ),
}

local dict = require("cmp_dictionary")
dict.setup({
  paths = { vim.g.user_provided_dict },
  exact_length = 3,
  first_case_insensitive = true,
  document = {
    enable = false,
  },
})

require("cmp_zsh").setup({
  filetypes = { "zsh" }, -- Filetypes to enable cmp_zsh source. default: {"*"}
})

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = "menu,menuone,noselect,noinsert,preview",
  },
  mapping = cmp.mapping.preset.insert(cmp_keymaps),
  sources = cmp.config.sources({
    { name = "copilot" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "zsh" },
    { name = "luasnip" },
    {
      name = "buffer",
      keyword_length = 3,
      max_item_count = 5,
    },
    {
      name = "dictionary",
      keyword_length = 3,
      max_item_count = 5,
    },
  }),
  window = {
    documentation = {
      border = "rounded",
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
    completion = {
      border = "rounded",
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
  },
  formatting = cmp_formatting,
})

-- Use buffer source for `/`.
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
