local treesitter_installed, treesitter = pcall(require, "nvim-treesitter.configs")

if not treesitter_installed then
  vim.notify("treesitter is not installed.")
  return
end

treesitter.setup({
  ensure_installed = {
    "vimdoc",
    "vim",
    "lua",
    "rust",
  },

  auto_install = true,

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-Space>",
      node_incremental = "<C-Space>",
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
      },
    },
  },
})

local context_installed, context = pcall(require, "treesitter-context")

if context_intalled then
  context.setup({
    enable = true,
  })
end
