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
local t = luasnip.text_node
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

luasnip.add_snippets("css", {
	snip("rosewater", t("#f5e0dc")),
	snip("flamingo", t("f2cdcd")),
	snip("pink", t("#f5c2e7")),
	snip("mauve", t("#cba6f7")),
	snip("red", t("#f38ba8")),
	snip("maroon", t("#eba0ac")),
	snip("peach", t("#fab387")),
	snip("yellow", t("#f9e2af")),
	snip("green", t("#a6e3a1")),
	snip("teal", t("#94e2d5")),
	snip("sky", t("#89dceb")),
	snip("sapphire", t("#74c7ec")),
	snip("blue", t("#89b4fa")),
	snip("lavender", t("#b4befe")),
	snip("text", t("#cdd6f4")),
	snip("subtext1", t("#bac2de")),
	snip("subtext0", t("#a6adc8")),
	snip("overlay2", t("#9399b2")),
	snip("overlay1", t("#7f849c")),
	snip("overlay0", t("#6c7086")),
	snip("surface2", t("#585b70")),
	snip("surface1", t("#45475a")),
	snip("surface0", t("#313244")),
	snip("base", t("#1e1e2e")),
	snip("mantle", t("#181825")),
	snip("crust", t("#11111b"))
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

local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
local handlers_ok, handlers = pcall(require, "nvim-autipairs.completion.handlers")
if not (cmp_autopairs_ok and handlers_ok) then return end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {
	filetypes = {
		["*"] = {
			["("] = {
				kind = {
					cmp.lsp.CompletionItemKind.Function,
					cmp.lsp.CompletionItemKind.Method
				},
				handler = handlers["*"]
			}
		}
	}
})
