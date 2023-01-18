local lspconfig_installed, lspconfig = pcall(require, "lspconfig")
if not lspconfig_installed then return end

local function format_on_save(bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.g.AlphaKeks,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format()
		end
	})
end

local function highlight_word(bufnr)
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = vim.g.AlphaKeks,
		buffer = bufnr,
		callback = function()
			local utils_installed, utils = pcall(require, "nvim-treesitter.ts_utils")
			if not utils_installed then return end

			local node = utils.get_node_at_cursor()
			if not node then return end

			local node_text = vim.treesitter.get_node_text(node, 0)
			if vim.g.current_node ~= node_text then
				vim.g.current_node = node_text
				vim.lsp.buf.clear_references()

				local node_type = vim.treesitter.get_node_at_cursor()
				if node_type == "identifier" or node_type == "property_identifier" then
					vim.lsp.buf.document_highlight()
				end
			end
		end
	})
end

local function apply_keymaps(bufnr)
	vim.keymap.set("n", "<leader><leader>", vim.lsp.buf.hover, { buffer = bufnr })
	vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })

	local saga_installed, _ = pcall(require, "lspsaga")
	if saga_installed then
		vim.keymap.set("n", "gd", function()
			vim.cmd.Lspsaga("goto_definition")
		end, { buffer = bufnr })
		vim.keymap.set("n", "ga", function()
			vim.cmd.Lspsaga("code_action")
		end, { buffer = bufnr })
		vim.keymap.set("n", "gl", function()
			vim.cmd.Lspsaga("show_cursor_diagnostics")
		end, { buffer = bufnr })
		vim.keymap.set("n", "gL", function()
			vim.cmd.Lspsaga("diagnostic_jump_next")
		end, { buffer = bufnr })
		vim.keymap.set("n", "gr", function()
			vim.cmd.Lspsaga("rename")
		end, { buffer = bufnr })
		vim.keymap.set("n", "gp", function()
			vim.cmd.Lspsaga("peek_definition")
		end, { buffer = bufnr })
	else
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr })
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr })
		vim.keymap.set("n", "gL", vim.diagnostic.goto_next, { buffer = bufnr })
		vim.keymap.set("n", "gr", function()
			vim.ui.input({ prompt = "New Name: " }, function(input)
				if not input then return end
				vim.lsp.buf.rename(input)
			end)
		end, { buffer = bufnr })
	end
end

local capabilities = nil
local cmp_installed, cmp = pcall(require, "cmp_nvim_lsp")
if cmp_installed then
	capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local rust_tools_installed, rust_tools = pcall(require, "rust-tools")
if rust_tools_installed then
	rust_tools.setup({
		tools = {
			inlay_hints = {
				auto = true,
				only_current_line = true,
				show_parameter_hints = true
			}
		},
		server = {
			standalone = true,
			on_attach = function(client, bufnr)
				format_on_save(bufnr)
				highlight_word(bufnr)
				apply_keymaps(bufnr)
			end,
			capabilities = capabilities,
			cmd = { "rustup", "run", "stable", "rust-analyzer" },
			settings = {
				["rust-analyzer"] = {
					cargo = {
						features = "all"
					},
					checkOnSave = {
						enable = true,
						command = "clippy",
						features = "all"
					},
					workspace = {
						symbol = {
							search = {
								kind = "all_symbols"
							}
						}
					}
				}
			}
		}
	})
end

lspconfig["tsserver"].setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
		highlight_word(bufnr)
		apply_keymaps(bufnr)
	end,
	capabilities = capabilities
})

local servers = {
	"bashls",
	"cssls",
	"emmet_ls",
	"html",
	"jsonls",
	"taplo"
}

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_attach = function(client, bufnr)
			if client.server_capabilities.documentFormattingProvider then
				format_on_save(bufnr)
			end
			if client.server_capabilities.documentHighlightProvider and server ~= "bashls" then
				highlight_word(bufnr)
			end
			apply_keymaps(bufnr)
		end,
		capabilities = capabilities
	})
end

local null_ls_installed, null_ls = pcall(require, "null-ls")
if null_ls_installed then
	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.prettierd.with({
				env = {
					PRETTIERD_DEFAULT_CONFIG = os.getenv("HOME") .. "/.config/prettier/prettier.config.js"
				}
			}),
			null_ls.builtins.formatting.sql_formatter
		},
		on_attach = function(client, bufnr)
			format_on_save(bufnr)
		end
	})
end

vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "" })
vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "" })
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "" })
vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "" })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
vim.diagnostic.config({
	virtual_text = {
		source = false,
		prefix = "",
		format = function(diagnostic) return "  " .. diagnostic.message end,
		severity = vim.diagnostic.severity.ERROR
	},
	update_in_insert = true,
	underline = false,
	severity_sort = true,
	float = {
		focusable = true,
		source = "always",
		header = "Diagnostics",
		prefix = " ",
		border = "rounded"
	}
})

vim.api.nvim_create_user_command("MasonSetup", function()
	require("mason").setup()
	vim.api.nvim_del_user_command("MasonSetup")
end, {})
