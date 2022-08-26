-- SNIPPETS : luasnip
local luasnip_staus, luasnip = pcall(require, "luasnip")
if (not luasnip_staus) then
	print("luasnip failed to load")
	return
end

luasnip.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI"
}

local new_snip = luasnip.snippet
local i = luasnip.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

luasnip.add_snippets("typescript", {
	new_snip("imp", fmt("import {{ {} }} from \"{}\";", {
		i(1, ""),
		i(2, "")
	})),

	new_snip("cmd", fmt([[
		import {{ SlashCommandBuilder, ChatInputCommandInteraction }} from "discord.js";
		import {{ reply }} from "../lib/functions/discord";
		module.exports = {{
			data: new SlashCommandBuilder()
							.setName("{1}")
							.setDescription("{2}")
							.addStringOption((o) =>
								o
									.setName("{3}")
									.setDescription("{4}")
									.setRequired("{5}")
							),
			async execute(interaction: ChatInputCommandInteraction) {{
				await interaction.deferReply();
				{6}
			}}
		}}
	]], {
		i(1, ""),
		i(2, ""),
		i(3, ""),
		i(4, ""),
		i(5, ""),
		i(6, "")
	})),

	new_snip("req", fmt([[
		const {1} = await {2};
		if (!{3}.success) return reply(interaction, {{ content: {4}.error }});
	]], {
		i(1, "h"),
		i(2, "function"),
		rep(1),
		rep(1)
	}))
})

-- CMP ICONS : lspkind
local lspkind_status, lspkind = pcall(require, "lspkind")
if (not lspkind_status) then
	print("lspkind failed to load")
	return
end

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

kind_icons = {
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

-- COMPLETION : cmp
local cmp_status, cmp = pcall(require, "cmp")
if (not cmp_status) then
	print("cmp faield to load")
	return
end

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
	formatting = { format = lspkind.cmp_format({ wirth_text = false, maxwidth = 69 }) },
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{ name = "emoji" }
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	}
}
