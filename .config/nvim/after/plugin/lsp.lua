-- LSP : lspconfig
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if (not lspconfig_status) then
	print("lspconfig failed to load")
	return
end

local lspconfig_on_attach = function(client, bufnr)
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
	-- disable ls formatting because i have separate formatters
	if client.name == "rust_analyzer" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	if client.name == "vuels" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
end

lspconfig.bashls.setup {
	on_attach = lspconfig_on_attach,
	cmd = { "bash-language-server", "start" }
}

lspconfig.cssls.setup {
	on_attach = lspconfig_on_attach,
	cmd = { "vscode-css-language-server", "--stdio" }
}

lspconfig.html.setup {
	on_attach = lspconfig_on_attach,
	cmd = { "vscode-html-language-server", "--stdio" }
}

lspconfig.jsonls.setup {
	on_attach = lspconfig_on_attach,
	cmd = { "vscode-json-language-server", "--stdio" }
}

lspconfig.rust_analyzer.setup {
	on_attach = lspconfig_on_attach,
	cmd = { "rustup", "run", "stable", "rust-analyzer" }
}

lspconfig.tsserver.setup {
	on_attach = lspconfig_on_attach,
	cmd = { "typescript-language-server", "--stdio" }
}

lspconfig.vuels.setup {
	on_attach = lspconfig_on_attach,
	cmd = { "vue-language-server", "--stdio" }
}
