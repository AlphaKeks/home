vim.lsp.setup = function(server_name, opts)
  local lspconfig_installed, lspconfig = pcall(require, "lspconfig")
  if lspconfig_installed then
    lspconfig[server_name].setup(opts or {})
  end
end

autocmd = vim.api.nvim_create_autocmd
augroup = vim.api.nvim_create_augroup
usercmd = function(name, callback, opts)
  vim.api.nvim_create_user_command(name, callback, opts or {})
end

nn = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts or {})
end

vn = function(lhs, rhs, opts)
  vim.keymap.set({ "v", "x" }, lhs, rhs, opts or {})
end
