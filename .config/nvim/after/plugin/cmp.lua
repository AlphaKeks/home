local cmp_installed, cmp = pcall(require, "cmp")
local luasnip_installed, luasnip = pcall(require, "luasnip")

if not (cmp_installed and luasnip_installed) then
  return
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ["<cr>"] = cmp.mapping.confirm({ select = true }),
    ["<Right>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end),
  }),

  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
  },

  formatting = {
    expandable_indicator = false,
    format = function(entry, item)
      item.menu = ""
      return item
    end,
  },

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
