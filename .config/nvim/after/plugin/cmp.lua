local cmp_installed, cmp = pcall(require, "cmp")
local luasnip_installed, luasnip = pcall(require, "luasnip")

if not cmp_installed then
  vim.notify("cmp is not installed.")
  return
end

if not luasnip_installed then
  vim.notify("luasnip is not installed.")
  return
end

local icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "", EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "", Operator = "",
  TypeParameter = "",
  KZ = "KZ",
}

cmp.setup({
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ["<cr>"] = cmp.mapping.confirm({
      select = true,
    }),

    ["<Right>"] = cmp.mapping.confirm({
      select = true,
    }),

    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),

    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),

    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end),
  }),

  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    --[[ {
      name = "kz",
      keyword_length = 3,
      max_item_count = 10,
    }, ]]--
  },

  formatting = {
    expandable_indicator = false,
    format = function(entry, item)
      item.menu = ""
      item.kind = icons[item.kind] or "?"
      return item
    end,
  },

  --[[ window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }, ]]--

  experimental = {
    ghost_text = "Comment",
  },

  views = {
    entries = "native",
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
})
