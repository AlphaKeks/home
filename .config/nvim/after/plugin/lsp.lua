local lspconfig_installed, lspconfig = pcall(require, "lspconfig")

if not lspconfig_installed then
  vim.notify("lspconfig is not installed.")
  return
end

local highlight_group = vim.api.nvim_create_augroup("HighlightReferences", { clear = true })
local format_group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

local function load_keymaps(bufnr)
  local function bufmap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end

  bufmap("n", "<Leader><Leader>", vim.lsp.buf.hover)
  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "gD", vim.lsp.buf.type_definition)
  bufmap("n", "gi", vim.lsp.buf.implementation)
  bufmap("n", "ga", vim.lsp.buf.code_action)
  bufmap("n", "gl", vim.diagnostic.open_float)
  bufmap("n", "gL", vim.diagnostic.goto_next)

  bufmap("n", "gr", function()
    vim.ui.input({ prompt = "New Name: " }, function(input)
      if input then
        vim.lsp.buf.rename(input)
      end
    end)
  end)

  bufmap("i", "<C-h>", vim.lsp.buf.signature_help)

  bufmap("n", "gp", peek_definition)
end

local function peek_definition()
  vim.api.nvim_open_win(0, true, {
    relative = "cursor",
    width = math.floor(0.4 * vim.o.columns),
    height = math.floor(0.35 * vim.o.lines),
    col = 0,
    row = 1,
    style = "minimal",
    border = "single",
  })

  vim.lsp.buf.definition()
  vim.wo.relativenumber = true

  local win_id = vim.fn.get_winid()

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win_id, true)
    vim.keymap.del("n", "q")
  end)
end

local function highlight_references(bufnr)
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = highlight_group,
    buffer = bufnr,
    callback = function()
      local treesitter_installed, utils = pcall(require, "nvim-treesitter.ts_utils")

      if not treesitter_installed then
        return
      end

      local current_node = utils.get_node_at_cursor()

      if not current_node then
        return
      end

      local node_text = vim.treesitter.get_node_text(current_node, 0)

      if vim.g.current_node == node_text then
        return
      end

      vim.g.current_node = node_text
      vim.lsp.buf.clear_references()

      local node_type = vim.treesitter.get_node():type()

      if node_type == "identifier" or node_type == "property_identifier" then
        vim.lsp.buf.document_highlight()
      end
    end,
  })
end

local function format_on_save(bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_installed, cmp = pcall(require, "cmp_nvim_lsp")

if cmp_installed then
  capabilities = cmp.default_capabilities(capabilities)
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "single",
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "single",
  }
)

local rust_tools_installed, rust_tools = pcall(require, "rust-tools")

local rust_analyzer_settings = {
  standalone = true,

  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil

    format_on_save(bufnr)
    highlight_references(bufnr)
    load_keymaps(bufnr)
  end,

  capabilities = capabilities,

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
      },

      checkOnSave = {
        enable = true,
        command = "clippy",
        features = "all",
      },
    },
  },
}

if not rust_tools_installed then
  lspconfig["rust_analyzer"].setup(rust_analyzer_settings)
else
  rust_tools.setup({
    server = rust_analyzer_settings,
    tools = {
      reload_workspace_from_cargo_toml = true,
      inlay_hints = {
        only_current_line = false,
        show_parameter_hints = false,
        other_hints_prefix = "",
      },
    },
  })
end

lspconfig["tsserver"].setup({
  on_attach = function(client, bufnr)
    format_on_save(bufnr)
    highlight_references(bufnr)
    load_keymaps(bufnr)
  end,

  capabilities = capabilities,
})

lspconfig["taplo"].setup({
  on_attach = function(client, bufnr)
    format_on_save(bufnr)
  end,

  capabilities = capabilities,
})

local mason_installed, mason = pcall(require, "mason")

if mason_installed then
  mason.setup({
    ui = {
      border = "single",
    },
  })
end

-- Sourcegraph
local sg = require("sg")
local sg_telescope = require("sg.telescope")

sg.setup({
  on_attach = function(client, bufnr)
    load_keymaps(bufnr)

    vim.keymap.set("n", "<Leader>e", ":e %:h<CR>")
    vim.keymap.set("n", "<Leader>ff", sg_telescope.fuzzy_search_results)
    vim.keymap.set("n", "<Leader>fr", sg_telescope.sg_references)
  end
})

local function open_sg_link(input)
  if not input then
    return
  end

  -- https://github.com/sourcegraph/sg.nvim/blob/master/crates/sg-nvim/src/lib.rs
  -- --> sg://github.com/sourcegraph/sg.nvim/-/blob/crates/sg-nvim/src/lib.rs

  -- Collect all parts from the given URL into a table
  local parts = {}

  for part in vim.gsplit(input, "/", { plain = true }) do
    -- Filter out empty parts (e.g. when there is a trailing `/`)
    if part ~= "" then
      table.insert(parts, part)
    end
  end

  -- Extract the repository owner and name
  local repo = string.format("%s/%s", parts[3], parts[4])
  -- `tree` or `blob` depending on whether the URL is pointing to a directory or file
  local path_ident = parts[5]
  local path = nil

  if parts[7] then
    path = ""

    for i = 7, #parts do
      path = string.format("%s/%s", path, parts[i])
    end
  end

  local sourcegraph_url = string.format("https://sourcegraph.com/github.com/%s", repo)

  if path_ident then
    sourcegraph_url = string.format("%s/-/%s", sourcegraph_url, path_ident)
  end

  if path then
    sourcegraph_url = string.format("%s%s", sourcegraph_url, path)
  end

  -- This throws errors sometimes. No idea why. Still works tho!
  pcall(vim.cmd.e, sourcegraph_url)
end

vim.keymap.set("n", "<Leader>sg", function()
  vim.ui.input({ prompt = "Sourcegraph: " }, open_sg_link)
end)

vim.api.nvim_create_user_command("SgOpen", function(input)
  open_sg_link(input.fargs[1])
end, {
    nargs = 1
  })
vim.api.nvim_create_user_command("SgSearch", sg_telescope.fuzzy_search_results, {})
