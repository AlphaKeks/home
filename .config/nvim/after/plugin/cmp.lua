local cmp_installed, cmp = pcall(require, "cmp")
local luasnip_installed, luasnip = pcall(require, "luasnip")
if (not cmp_installed) or (not luasnip_installed) then return end

cmp.setup({
	snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
	mapping = cmp.mapping.preset.insert({
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end)
	}),
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" }
	},
	formatting = {
		format = function(_, vim_item)
			local icons = {
				Text = "", Method = "", Function = "", Constructor = "", Field = "ﰠ",
				Variable = "", Class = "ﴯ", Interface = "", Module = "", Property = "ﰠ",
				Unit = "塞", Value = "", Enum = "", Keyword = "", Snippet = "",
				Color = "", File = "", Reference = "", Folder = "", EnumMember = "",
				Constant = "", Struct = "פּ", Event = "", Operator = "", TypeParameter = ""
			}
			vim_item.kind = icons[vim_item.kind]
			return vim_item
		end
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = { ghost_text = true }
})