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

  -- bufmap("n", "gp", peek_definition)
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
    -- client.server_capabilities.semanticTokensProvider = nil

    format_on_save(bufnr)
    highlight_references(bufnr)
    load_keymaps(bufnr)
  end,

  capabilities = capabilities,

  cmd = { "/mnt/dev/cargo-global-target/release/rust-analyzer" },

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
      },

      checkOnSave = true,

      -- cargo clippy --all-targets --all-features --workspace --tests
      check = {
        command = "clippy",
        allTargets = true,
        features = "all",
        invocationLocation = "workspace",
        extraArgs = { "--tests" },
      },

      imports = {
        granularity = {
          enforce = true,
          group = "one",
        },
      },
    },
  },
}

if not rust_tools_installed then
  lspconfig["rust_analyzer"].setup(rust_analyzer_settings)
else
  local dap = require("rust-tools.dap")
  local extension_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/codelldb/extension"
  local codelldb_path = extension_path .. "/adapter/codelldb"
  local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

  local old_on_attach = rust_analyzer_settings.on_attach

  rust_analyzer_settings.on_attach = function(client, bufnr)
    old_on_attach(client, bufnr)
    vim.keymap.set("n", "<Leader><Leader>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
  end

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
    dap = {
      adapter = dap.get_codelldb_adapter(codelldb_path, liblldb_path),
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
    load_keymaps(bufnr)
  end,

  capabilities = capabilities,
})

lspconfig["jsonls"].setup({
  on_attach = function(client, bufnr)
    format_on_save(bufnr)
    load_keymaps(bufnr)
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
