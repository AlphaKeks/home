local treesitter_installed, treesitter = pcall(require, "nvim-treesitter.configs")

if not treesitter_installed then
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

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
      },
    },
  },
})
