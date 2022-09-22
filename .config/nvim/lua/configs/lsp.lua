local lsp_ok, lsp = pcall(require, "lspconfig")
if lsp_ok then
	local function format_on_save(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end
			})
		end
	end

	capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
	if cmp_ok then capabilities = cmp.update_capabilities(capabilities) end

	vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "" })

	vim.diagnostic.config {
		virtual_text = true,
		signs = { active = signs },
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			source = "always",
			header = "",
			prefix = "",
			border = "rounded"
		},
	}

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	local ok, lsp = pcall(require, "lspconfig")
	if not ok then
		print "lspconfig failed to load."
		return
	end

	local attach_default = function(client, bufnr)
		format_on_save(client, bufnr)
	end

	lsp.bashls.setup {
		on_attach = attach_default,
		capabilities = capabilities
	}

	lsp.cssls.setup {
		on_attach = attach_default,
		capabilities = capabilities
	}

	lsp.emmet_ls.setup {
		on_attach = attach_default,
		capabilities = capabilities
	}

	lsp.html.setup {
		on_attach = attach_default,
		capabilities = capabilities
	}

	lsp.jsonls.setup {
		on_attach = attach_default,
		capabilities = capabilities
	}

	lsp.rust_analyzer.setup {
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities
	}

	lsp.tsserver.setup {
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities
	}

	local null_ok, null = pcall(require, "null-ls")
	if null_ok then

		local diagnostics = null.builtins.diagnostics
		local formatting = null.builtins.formatting
		local actions = null.builtins.code_actions

		local null_sources = {
			diagnostics.markdownlint,
			formatting.markdownlint,
			formatting.prettierd.with {
				filetypes = { "javascript", "typescript" },
				env = {
					PRETTIERD_DEFAULT_CONFIG = "/home/max/.config/prettier/prettier.config.js"
				}
			},
			formatting.rustfmt.with {
				extra_args = { "--edition=2021" }
			}
		}
		
		-- only use eslint if the project uses it
		-- (this is still wip)
		local plenary_ok, plenary = pcall(require, "plenary")
		if plenary_ok then
			local cwd = vim.fn.expand("%:p:h")
			local eslint_check = plenary.scandir.scan_dir(cwd, {
				hidden = true,
				depth = 1,
				search_pattern = "eslint"
			})

			if eslint_check[1] then
				table.insert(null_sources, diagnostics.eslint_d.with {
					filetypes = { "javascript", "typescript", "vue" }
				})
				table.insert(null_sources, actions.eslint_d.with {
					filetypes = { "javascript", "typescript" }
				})
			end
		end

		null.setup {
			debug = false,
			sources = null_sources,
			on_attach = attach_default
		}
	end

	local mason_ok, mason = pcall(require, "mason")
	if mason_ok then mason.setup {} end
end
