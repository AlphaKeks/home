local mason_installed, mason = pcall(require, "mason")
if mason_installed then
  mason.setup({})
end

local function setup_keymaps(buffer)
  local function bmap(modes, lhs, rhs)
    vim.keymap.set(modes, lhs, rhs, { buffer = buffer })
  end

  bmap("n", "gd", vim.lsp.buf.definition)
  bmap("n", "gD", vim.lsp.buf.type_definition)
  bmap("n", "<Leader><Leader>", vim.lsp.buf.hover)
  bmap("n", "ga", vim.lsp.buf.code_action)
  bmap("n", "gr", vim.lsp.buf.rename)
  bmap("n", "fr", vim.lsp.buf.references)
  bmap("n", "gi", vim.lsp.buf.implementation)
  bmap("i", "<C-h>", vim.lsp.buf.signature_help)
end

local function format_on_save(buffer)
  autocmd("BufWritePre", {
    group = augroup("lsp-format-on-save", { clear = true }),
    callback = function()
      vim.lsp.buf.format()
    end
  })
end

autocmd("LspAttach", {
  group = augroup("lsp-default-attach", { clear = true }),
  callback = function(args)
    -- enable completion via <C-x><C-o>
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    setup_keymaps(args.buf)

    usercmd("Format", function()
      vim.lsp.buf.format()
    end)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, { border = "single" }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, { border = "single" }
    )

    local inlay_hints_installed, inlay_hints = pcall(require, "lsp-inlayhints")
    if inlay_hints_installed then
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      inlay_hints.on_attach(client, args.buf)
    end
  end,
})

vim.lsp.setup("rust_analyzer", {
  on_attach = function(client, buffer)
    format_on_save(buffer)
  end,
  cmd = { "/mnt/dev/cargo-global-target/release/rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
      },
      checkOnSave = true,
      check = {
        command = "clippy",
        allTargets = true,
        features = "all",
        invocationLocation = "workspace",
        extraArgs = { "--tests" },
      },
    },
  },
})

vim.lsp.setup("tsserver")
vim.lsp.setup("taplo")
