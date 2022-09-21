format_on_save = function(client, bufnr)
	if client.supports_method('textDocument/formatting') then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd('BufWritePre', {
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

local cmp_ok, cmp = pcall(require, 'cmp_nvim_lsp')
if cmp_ok then capabilities = cmp.update_capabilities(capabilities) end

vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = '', numhl = '' })

vim.diagnostic.config {
	virtual_text = true,
	signs = { active = signs },
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = 'minimal',
		source = 'always',
		header = '',
		prefix = '',
		border = 'rounded'
	},
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

local ok, lsp = pcall(require, 'lspconfig')
if not ok then
	print 'lspconfig failed to load.'
	return
end

lsp.bashls.setup {
	on_attach = function(client, bufnr)
		format_on_save(client, bufnr)
	end,
	capabilities = capabilities
}

lsp.cssls.setup {
	on_attach = function(client, bufnr)
		format_on_save(client, bufnr)
	end,
	capabilities = capabilities
}

lsp.html.setup {
	on_attach = function(client, bufnr)
		format_on_save(client, bufnr)
	end,
	capabilities = capabilities
}

lsp.jsonls.setup {
	on_attach = function(client, bufnr)
		format_on_save(client, bufnr)
	end,
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

lsp.vuels.setup {
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end,
	capabilities = capabilities
}

local h_ok, h = pcall(require, 'alphakeks.keymaps')
if h_ok then

	h.map('n', '<leader><leader>', '<cmd>lua vim.lsp.buf.hover()<CR>', h.def)
	h.map('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', h.def)
	h.map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', h.def)
	h.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', h.def)
	h.map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', h.def)
	h.map('n', 'gL', function()
		vim.diagnostic.goto_next()
		vim.diagnostic.open_float()
	end, h.def)
	h.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', h.def)
	h.map('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', h.def)
	h.map('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', h.def)
	h.map('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', h.def)
	h.map('n', 'gR', function()
		require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy {
			prompt_title = 'References',
			layout_config = {
				height = 0.35
			}
		})
	end, h.def)

end

local null_ok, null = pcall(require, 'null-ls')
if null_ok then

	local diagnostics = null.builtins.diagnostics
	local formatting = null.builtins.formatting
	local actions = null.builtins.code_actions

	local sources = {
		actions.eslint_d.with {
			filetypes = { 'javascript', 'typescript', 'vue' }
		},
		
		formatting.prettierd.with {
			filetypes = { 'javascript', 'typescript', 'vue' },
			env = {
				PRETTIERD_DEFAULT_CONFIG = '/home/max/.config/prettier/prettier.config.js'
			}
		},
		formatting.rustfmt.with {
			extra_args = { '--edition=2021' }
		}
	}
	
	local scan = require('plenary').scandir
	local cwd = vim.fn.expand('%:p:h')
	local eslint_check = scan.scan_dir(cwd, {
		hidden = true,
		depth = 1,
		search_pattern = 'eslint'
	})

	if eslint_check[1] then
		table.insert(sources, diagnostics.eslint_d.with {
			filetypes = { 'javascript', 'typescript', 'vue' }
		})
	end

	print(vim.inspect(sources))

	null.setup {
		debug = false,
		sources = sources,
		on_attach = function(client, bufnr)
			format_on_save(client, bufnr)
		end
	}

end

local mason_ok, mason = pcall(require, 'mason')
if mason_ok then mason.setup {} end
