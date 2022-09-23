local ls_ok, luasnip = pcall(require, "luasnip")
local cmp_ok, cmp = pcall(require, "cmp")

if not (ls_ok and cmp_ok) then return end

vim.g.icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = ""
}

local snip = luasnip.snippet
local i = luasnip.insert_node
local f = require("luasnip.extras.fmt").fmt

luasnip.add_snippets("typescript", {
	snip("imp", f([[import {{ {1} }} from "{2}";]], {
		i(1, ""),
		i(2, "")
	})),

	snip("fn", f([[
		{6}const {1} = {4}({2}): {3} => {{
			{5}
		}}
	]], {
		i(1, "myFunction"),
		i(2, "args: any"),
		i(3, "void"),
		i(4, ""),
		i(5, ""),
		i(6, "")
	}))
})

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert {
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" })
	},
	formatting = {
		format = function(_entry, vim_item)
			vim_item.kind = (vim.g.icons[vim_item.kind] or "")
			return vim_item
		end
	},
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" }
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	}
}
