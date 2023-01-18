local cmp_installed, cmp = pcall(require, "cmp")
local luasnip_installed, luasnip = pcall(require, "luasnip")
if (not cmp_installed) or (not luasnip_installed) then return end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert({
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end),
		["<C-n>"] = function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end,
		["<C-p>"] = function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end
	}),
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer", max_item_count = 3, keyword_length = 5 }
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
			-- vim_item.abbr = string.sub(vim_item.abbr, 1, 50) -- trim item length
			vim_item.menu = ""
			return vim_item
		end,
		expandable_indicator = false
	},
	window = {
		completion = cmp.config.window.bordered({
			scrollbar = false,
		}),
		documentation = cmp.config.window.bordered({
			max_height = 10
		}),
	},
	experimental = { ghost_text = true },
	preselect = cmp.PreselectMode.None,
})
