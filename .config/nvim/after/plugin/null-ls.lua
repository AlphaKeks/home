-- null-ls
local null_ls_status, null_ls = pcall(require, "null-ls")
if (not null_ls_status) then
	print("null-ls failed to load")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
	debug = false,
	sources = {
		diagnostics.eslint_d.with { filetypes = { "javascript" } },
		formatting.prettierd.with {
			filetypes = { "javascript", "typescript", "vue" },
			extra_filetypes = { "yaml" },
			env = { PRETTIERD_DEFAULT_CONFIG = "/home/alpha/.config/prettier/prettier.config.js" }
		},
		formatting.rustfmt.with { extra_args = { "--edition=2021" } }
	},
	on_attach = function(client, bufnr)
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
}
