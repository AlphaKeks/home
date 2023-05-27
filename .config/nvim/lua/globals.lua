vim.lsp.setup = function(server_name, opts)
  local lspconfig_installed, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_installed then
    return
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_installed, cmp = pcall(require, "cmp_nvim_lsp")
  if cmp_installed then
    capabilities = cmp.default_capabilities(capabilities)
  end

  local default_opts = {
    capabilities = capabilities,
  }

  for key, value in pairs(opts or {}) do
    default_opts[key] = value
  end

  lspconfig[server_name].setup(default_opts)

  return default_opts
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
