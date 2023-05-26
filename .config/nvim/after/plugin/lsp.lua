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
  bmap("i", "<C-i>", vim.lsp.buf.signature_help)
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
  end,
})

vim.lsp.setup("rust_analyzer", {
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
